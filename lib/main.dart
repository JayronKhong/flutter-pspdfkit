import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pspdfkit_flutter/pspdfkit.dart';
import 'package:pspdfkit_flutter/widgets/pspdfkit_widget.dart';
import 'package:test_pspdfkit/file_utils.dart';
import 'package:test_pspdfkit/platform_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PSPDFKIT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter PSPDFKIT'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late final File? file;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      file = await extractAsset(context, 'assets/pdf/pdf1.pdf');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: PlatformUtils.isAndroid(),
      resizeToAvoidBottomInset: PlatformUtils.isIOS(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Testing',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          padding: PlatformUtils.isCupertino(context)
              ? null
              : const EdgeInsets.only(top: kToolbarHeight),
          child: PspdfkitWidget(
            documentPath: file?.path,
            configuration: const {
              scrollDirection: 'horizontal',
              pageTransition: 'curl',
              spreadFitting: 'fill',
              androidShowSearchAction: true,
              inlineSearch: false,
              showThumbnailBar: 'floating',
              androidShowThumbnailGridAction: true,
              androidShowOutlineAction: true,
              androidShowAnnotationListAction: true,
              showPageLabels: true,
              documentLabelEnabled: false,
              invertColors: false,
              androidGrayScale: false,
              enableAnnotationEditing: true,
              enableTextSelection: false,
              androidShowBookmarksAction: false,
              androidEnableDocumentEditor: false,
              androidShowShareAction: true,
              androidShowPrintAction: false,
              androidShowDocumentInfoView: true,
              appearanceMode: 'default',
              androidDefaultThemeResource: 'PSPDFKit.Theme.Example',
              iOSRightBarButtonItems: [
                'thumbnailsButtonItem',
                //'activityButtonItem',
                'searchButtonItem',
                'annotationButtonItem'
              ],
              iOSLeftBarButtonItems: ['settingsButtonItem'],
              iOSAllowToolbarTitleChange: false,
              toolbarTitle: null,
              settingsMenuItems: [
                'pageTransition',
                'scrollDirection',
                'androidTheme',
                'iOSAppearance',
                'androidPageLayout',
                'iOSPageMode',
                'iOSSpreadFitting',
                'androidScreenAwake',
                //'iOSBrightness'
              ],
              showActionNavigationButtons: false,
              pageMode: 'single',
              firstPageAlwaysSingle: true
            },
          ),
        ),
      ),
    );
  }
}
