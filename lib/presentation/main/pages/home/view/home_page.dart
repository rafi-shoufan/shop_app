import 'package:advanced/app/dependency_injection.dart';
import 'package:advanced/domain/models/models.dart';
import 'package:advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:advanced/presentation/main/pages/home/view_model/home_view_model.dart';
import 'package:advanced/presentation/resources/color_manager.dart';
import 'package:advanced/presentation/resources/routes_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../resources/strings_manager.dart';
import '../../../../resources/values_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _homeViewModel = instance<HomeViewModel>();

  _bind() {
    _homeViewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _homeViewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(
                context,
                _getContentWidget(),
                    () {
                  _homeViewModel.start();
                }
            )
                ?? _getContentWidget();
          },
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getBannersCarousel(),
        _getSection(AppStrings.services.tr()),
        _getServices(),
        _getSection(AppStrings.stores.tr()),
        _getStores(),
      ],
    );
  }

  Widget _getBannersCarousel() {
    return StreamBuilder<List<Banners>>(
      stream: _homeViewModel.outputBanners,
      builder: (context, snapshot) {
        return _getBannerWidget(snapshot.data);
      },
    );
  }

  _getBannerWidget(List<Banners> ? banners) {
    if (banners != null) {
      return CarouselSlider(
        items: banners.map((bannerItem) =>
            SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: AppSize.s1_5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      side: BorderSide(
                          color: ColorManager.white,
                          width: AppSize.s1
                      )
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    child: Image.network(
                      bannerItem.image,
                      fit: BoxFit.cover,),
                  ),
                )
            )).toList(),
        options: CarouselOptions(
          height: AppSize.s190,
          autoPlay: true,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
        ),
      );
    } else {
      return Container();
    }
  }


  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: AppPadding.p12,
          left: AppPadding.p12,
          top: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        title,
        style: Theme
            .of(context)
            .textTheme
            .labelSmall,
      ),
    );
  }

  Widget _getServices() {
    return StreamBuilder<List<Services>>(
      stream: _homeViewModel.outputServices,
      builder: (context, snapshot) {
        return _getServiceWidget(snapshot.data);
      },
    );
  }

  _getServiceWidget(List<Services> ? service) {
    if (service != null) {
      return Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p12, right: AppPadding.p12),
        child: Container(
          height: AppSize.s160,
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: service.map((serviceItem) => Card(
              elevation: AppSize.s4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  side: BorderSide(
                      color: ColorManager.primary,
                      width: AppSize.s1
                  )
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    child: Image.network(
                      serviceItem.image,
                      fit: BoxFit.cover,
                    width: AppSize.s120,
                    height: AppSize.s120,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: AppPadding.p8),
                  child:  Align(
                      alignment: Alignment.center,
                      child:  Text(
                          serviceItem.title,
                          textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                  )
                  ),
                ],
              ),
            )
            ).toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStores(){
    return StreamBuilder<List<Stores>>(
      stream: _homeViewModel.outputStores,
      builder: (context, snapshot) {
        return _getStoresWidget(snapshot.data);
      },
    );
  }

  _getStoresWidget(List<Stores> ? stores){
    if(stores !=null){
      Padding(
        padding: EdgeInsets.only(
          right:AppPadding.p12 ,
          top: AppPadding.p12,
          left:AppPadding.p12,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
                crossAxisCount: AppSize.s2,
            crossAxisSpacing: AppSize.s8,
            mainAxisSpacing: AppSize.s8,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(stores.length, (index) {
              return InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                },
                child: Card(
                  elevation: AppSize.s4,
                  child: Image.network(
                      stores[index].image,
                  fit: BoxFit.cover
                  ),
                ),
              );
            }),

            ),
          ],
        ),
      );
    }else{
      return Container();
    }
  }
}
