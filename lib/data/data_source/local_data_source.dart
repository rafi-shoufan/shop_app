import 'package:advanced/data/network/error_handler.dart';

import '../network/app_api.dart';
import '../response/responses.dart';


const CACHE_HOME_KEY = 'CACHE_HOME_KEY';
const CACHE_HOME_INTERVAL = 60*1000;

abstract class LocalDataSource{
  Future<HomeResponse> getHomeData();
  Future<void> saveHomeToCache(HomeResponse homeResponse);
  void clearCache(); /// بفضيها مشان اذا طلعت من حسابي وحدا تاني فات على حسابو بأقل من دقيقة ما يطلعلو الكاش تبع حسابي
  void removeFromCache(String key); /// هاي مشان في حال كان عندي ليستا favourite وجيت ضفت شغلة عليها وفتحت صفحة ال favourites لازم يجيب البيانات من ال server اما اذا جابن من الكاش ما بيظهر اخر عنصر انضاف
}

class LocalDataSourceImpl implements LocalDataSource{

  Map<String , CachedItems> cacheMap = Map();

  @override
  Future<HomeResponse> getHomeData() async{
    CachedItems ? cachedItems = cacheMap[CACHE_HOME_KEY];
    if(cachedItems != null && cachedItems.isValid(CACHE_HOME_INTERVAL)){
      return cachedItems.data;
    }else{
      /// return an error that cache is not there or it is not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache  (HomeResponse homeResponse) async{
    cacheMap[CACHE_HOME_KEY] = CachedItems(homeResponse);
  }

  @override
  clearCache() {
    cacheMap.clear();
  }

  @override
  removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItems{
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CachedItems(this.data);
}

extension CachedItemsExtension on CachedItems {
  bool isValid(int expirationTime){
    int currentTimeInMillySeconds = DateTime.now().millisecondsSinceEpoch;
    bool isValid = currentTimeInMillySeconds - cacheTime <  expirationTime;
    return isValid;
  }
}