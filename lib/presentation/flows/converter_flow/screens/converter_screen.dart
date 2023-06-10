import 'package:exchange/app+injection/di.dart';
import 'package:exchange/core/resources/colors.dart';
import 'package:exchange/core/resources/constants.dart';
import 'package:exchange/presentation/custom_widgets/custom_header/custom_header.dart';
import 'package:exchange/presentation/flows/converter_flow/blocs/convert_bloc.dart';
import 'package:exchange/presentation/flows/converter_flow/widgets/clear_button.dart';
import 'package:exchange/presentation/flows/converter_flow/widgets/convert_currency_widget.dart';
import 'package:exchange/presentation/flows/home_flow/bloc/exchange_bloc.dart';
import 'package:exchange/presentation/flows/home_flow/components/currency_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../domain/entities/currency_entity.dart';
import '../../../custom_widgets/text_translation.dart';
import '../widgets/currency_dialog.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({Key key}) : super(key: key);

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> with SingleTickerProviderStateMixin {


  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondController = TextEditingController();

  final bloc = locator<ConvertBloc>();

  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: Offset(0, 182.sp),
    ).animate(_controller);
  }

  void _startAnimation() {
    if (_animation.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void openDialog(
      BuildContext context, List<CurrencyEntity> data, Function(CurrencyEntity) onSelect) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyDialog(
          itemList: data,
          onSelect: onSelect,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Theme.of(context).primaryColor,
          child: SvgPicture.asset(ImagesKeys.phoneCall)),
      body: SingleChildScrollView(
        child: BlocConsumer<ConvertBloc, ConvertState>(
          bloc: bloc,
          listener: (context, state) {
            if (!state.isSwitched) {
              secondController.text = state.toAmount;
            } else {
              firstController.text = state.fromAmount;
            }
          },
          builder: (context, state) {
            return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 270.sp,
                child: Column(
                  children: [
                    CustomHeader(
                      date: state.lastUpdate,
                    ),
                  ],
                ),
              ),
              if (state.status == ExchangePageStatus.init ||
                  state.status == ExchangePageStatus.loading)
                const CustomCircularProgressIndicator(),
              if (state.status == ExchangePageStatus.error) Text(state.error),
              if (state.status == ExchangePageStatus.success)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0.sp, vertical: 24.sp),
                  child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextTranslation(
                              "Buy",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            ScreenUtil().setVerticalSpacing(12),
                            Transform.translate(
                              offset: _animation.value,
                              child: ConvertCurrencyWidget(
                                key: const ObjectKey("first"),
                                controller: firstController,
                                selectedCurrency: state.fromCurrency,
                                enable: !state.isSwitched,
                                onAmountChange: (amount) {
                                  bloc.setData(fromAmount: amount);
                                },
                                onSelect: () {
                                  openDialog(context, state.first, (currency) {
                                    bloc.setData(fromCurrency: currency);
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.0.sp),
                              child: Center(
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    onTap: () {
                                      bloc.setData(isSwitched: !state.isSwitched);
                                      _startAnimation();
                                    },
                                    child: SvgPicture.asset(
                                      ImagesKeys.switcher,
                                      color: locator<AppThemeColors>().secondaryColor,
                                    )),
                              ),
                            ),
                            Transform.translate(
                              offset: _animation.value * -1,
                              child: ConvertCurrencyWidget(
                                key: const ObjectKey("second"),
                                controller: secondController,
                                selectedCurrency: state.toCurrency,
                                enable: state.isSwitched,
                                onAmountChange: (amount) {
                                  bloc.setData(toAmount: amount);
                                },
                                onSelect: () {
                                  openDialog(context, state.second, (currency) {
                                    bloc.setData(toCurrency: currency);
                                  });
                                },
                              ),
                            ),
                            ScreenUtil().setVerticalSpacing(26),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: ClearButton(
                                onClear: () {
                                  firstController.clear();
                                  secondController.clear();
                                  bloc.reset();
                                },
                              ),
                            ),
                            ScreenUtil().setVerticalSpacing(26),
                            Align(
                                alignment: AlignmentDirectional.center,
                                child: TextTranslation(
                                  "current foreign",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ))
                          ],
                        );
                      }),
                )
            ]);
          },
        ),
      ),
    );
  }
}
