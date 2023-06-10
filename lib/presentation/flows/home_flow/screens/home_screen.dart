import 'package:exchange/app+injection/di.dart';
import 'package:exchange/core/resources/constants.dart';
import 'package:exchange/domain/entities/currency_entity.dart';
import 'package:exchange/presentation/custom_widgets/animation/fade_tans_animation.dart';
import 'package:exchange/presentation/custom_widgets/custom_header/custom_header.dart';
import 'package:exchange/presentation/custom_widgets/text_translation.dart';
import 'package:exchange/presentation/flows/home_flow/bloc/exchange_bloc.dart';
import 'package:exchange/presentation/flows/home_flow/components/currency_list.dart';
import 'package:exchange/presentation/flows/home_flow/components/search_bar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  ScrollController animateButtonController;

  AnimationController animationController;
  Animation<Offset> tweenAnimation;

  final bloc = locator<ExchangeBloc>();

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();

    animateButtonController = ScrollController();

    animationController =
        AnimationController(duration: const Duration(milliseconds: 600), vsync: this);

    animationController.forward();

    tweenAnimation = Tween<Offset>(
      end: Offset.zero,
      begin: const Offset(0, 2.0),
    ).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));

    animateButtonController.addListener(() {
      if (animateButtonController.position.userScrollDirection == ScrollDirection.reverse) {
        if (tweenAnimation.isCompleted) animationController.reverse();
      }
      if (animateButtonController.position.userScrollDirection == ScrollDirection.forward) {
        animationController.forward();
      }
    });

    print('getCurrencies');

    bloc.getCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedBuilder(
          animation: tweenAnimation,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Theme.of(context).primaryColor,
            child: SvgPicture.asset(ImagesKeys.phoneCall),
          ),
          builder: (context, child) {
            return SlideTransition(position: tweenAnimation, child: child);
          }),
      body: BlocBuilder<ExchangeBloc, ExchangeState>(
        bloc: bloc,
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 270.sp,
                child: Stack(
                  //alignment: Alignment.bottomCenter,
                  children: [
                    CustomHeader(
                      date: state.lastUpdate,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FadeTransAnimation(
                        delayInMillisecond: 300,
                        child: Padding(
                            padding: EdgeInsets.all(18.0.sp),
                            child: SearchBar(
                              onChange: (value) {
                                bloc.searchCurrencies(value);
                              },
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              if (state.status == ExchangePageStatus.init ||
                  state.status == ExchangePageStatus.loading)
                const CustomCircularProgressIndicator(),
              if (state.status == ExchangePageStatus.success)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 8.sp),
                  child: TextTranslation(TranslationsKeys.current,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
              if (state.status == ExchangePageStatus.success)
                ScreenUtil().setVerticalSpacing(32.sp),
              if (state.status == ExchangePageStatus.success)
                Expanded(
                  child: CurrencyList(
                    scrollController: animateButtonController,
                    data: state.displayList,
                  ),
                ),
              if (state.status == ExchangePageStatus.error) Text(state.error),
              ScreenUtil().setVerticalSpacing(26.sp),
            ],
          );
        },
      ),
    );
  }
}
