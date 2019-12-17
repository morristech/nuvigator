import 'package:example/samples/modules/sample_one/navigation/sample_one_router.dart';
import 'package:flutter/material.dart';
import 'package:nuvigator/nuvigator.dart';
import 'package:provider/provider.dart';

import '../bloc/sample_two_bloc.dart';
import '../screen/screen_one.dart';
import '../screen/screen_two.dart';

part 'sample_two_router.g.dart';

@NuRouter()
class SampleTwoRouter extends BaseRouter {
  @override
  WrapperFn get screensWrapper => (BuildContext context, Widget screenWidget) {
        return Provider<SampleTwoBloc>.value(
          value: SampleTwoBloc(),
          child: screenWidget,
        );
      };

  @NuRoute()
  ScreenRoute<String> screenOne({String testId}) => ScreenRoute(
        builder: (context) => ScreenOne(
          toScreenTwo: () => toScreenTwo(),
        ),
      );

  @NuRoute(pushMethods: [PushMethodType.push, PushMethodType.pushReplacement])
  ScreenRoute<String> screenTwo() => ScreenRoute<String>(
        builder: (context) => ScreenTwo(
          closeFlow: () => nuvigator.closeFlow(),
          toSampleOne: () => Router.of<SampleOneRouter>(context)
              .toScreenOne(testId: 'From SampleTwo'),
        ),
      );

  @override
  Map<RouteDef, ScreenRouteBuilder> get screensMap => _$screensMap;
}
