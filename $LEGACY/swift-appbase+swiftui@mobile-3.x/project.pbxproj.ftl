<#import "/$/modelbase.ftl" as modelbase>
<#import "/$/appbase.ftl" as appbase>
<#macro print_files_pbxproj folder>
	<#if folder.type == 'file'>
		${folder.hash2} /* ${folder.name} */ = {
	<#else>
		${folder.hash} /* ${folder.name} */ = {
	</#if>
			isa = PBXGroup;
			children = (
	<#list folder.children as file>
		<#if file.type == 'file'>
				${file.hash} /* ${swift.nameType(file.name)}View.swift */,
		<#else>
			  ${file.hash} /* ${file.name} */,
		</#if>
		<#if file.type == 'file' && file.children?? && file.children?size != 0>
				${file.hash2} /* ${file.name} */,
		</#if>
	</#list>
			);
			path = ${folder.name};
			sourceTree = "<group>";
		};

	<#list folder.children as file>
		<#if file.type == 'file' && (!file.children?? || file.children?size == 0)><#continue></#if>
<@print_files_pbxproj folder=file />
	</#list>
</#macro>
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 56;
	objects = {
/* Begin PBXBuildFile section */
		AA6739D42A3B502A0040A062 /* swiftui_test_envApp.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA6739D32A3B502A0040A062 /* swiftui_test_envApp.swift */; };
		AA6739D62A3B52350040A062 /* IndexView.swift in Sources */ = {isa = PBXBuildFile; fileRef = AA6739D52A3B52350040A062 /* IndexView.swift */; };
		AA6739E82A3B89140040A062 /* Assets.xcassets in Resources */ = {isa = PBXBuildFile; fileRef = AA6739E72A3B89140040A062 /* Assets.xcassets */; };
<#list pages as page>
	<#assign pageName = page.uri?substring(page.uri?last_index_of("/") + 1)>
		${page.hash!''} /* ${swift.nameType(pageName)}View.swift in Sources */ = {isa = PBXBuildFile; fileRef = ${page.hash!''} /* ${swift.nameType(pageName)}View.swift */; };
</#list>
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
		AA6739B92A3B40270040A062 /* swiftui-test-env.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = "swiftui-test-env.app"; sourceTree = BUILT_PRODUCTS_DIR; };
		AA6739D32A3B502A0040A062 /* swiftui_test_envApp.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = swiftui_test_envApp.swift; sourceTree = "<group>"; };
		AA6739D52A3B52350040A062 /* IndexView.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = IndexView.swift; sourceTree = "<group>"; };
		AA6739E72A3B89140040A062 /* Assets.xcassets */ = {isa = PBXFileReference; lastKnownFileType = folder.assetcatalog; path = Assets.xcassets; sourceTree = "<group>"; };
<#list pages as page>
	<#assign pageName = page.uri?substring(page.uri?last_index_of("/") + 1)>
		${page.hash!''} /* ${swift.nameType(pageName)}View.swift */ = {isa = PBXFileReference; fileEncoding = 4; lastKnownFileType = sourcecode.swift; path = ${swift.nameType(pageName)}View.swift; sourceTree = "<group>"; };
</#list>
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		AA6739B62A3B40270040A062 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		AA6739B02A3B40270040A062 = {
			isa = PBXGroup;
			children = (
				AA6739E72A3B89140040A062 /* Assets.xcassets */,
				AA6739D32A3B502A0040A062 /* swiftui_test_envApp.swift */,
				AA6739CF2A3B4FF20040A062 /* Views */,
				AA6739BA2A3B40270040A062 /* Products */,
			);
			sourceTree = "<group>";
		};
		AA6739BA2A3B40270040A062 /* Products */ = {
			isa = PBXGroup;
			children = (
				AA6739B92A3B40270040A062 /* swiftui-test-env.app */,
			);
			name = Products;
			sourceTree = "<group>";
		};
		AA6739CF2A3B4FF20040A062 /* Views */ = {
			isa = PBXGroup;
			children = (
<#list project.children![] as folder>
				${folder.hash} /* ${folder.name} */,
</#list>
				AA6739D52A3B52350040A062 /* IndexView.swift */,
			);
			path = Views;
			sourceTree = "<group>";
		};
<#list project.children![] as folder>
<@print_files_pbxproj folder=folder />
</#list>
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		AA6739B82A3B40270040A062 /* swiftui-test-env */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = AA6739C72A3B40290040A062 /* Build configuration list for PBXNativeTarget "swiftui-test-env" */;
			buildPhases = (
				AA6739B52A3B40270040A062 /* Sources */,
				AA6739B62A3B40270040A062 /* Frameworks */,
				AA6739B72A3B40270040A062 /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = "swiftui-test-env";
			productName = "swiftui-test-env";
			productReference = AA6739B92A3B40270040A062 /* swiftui-test-env.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		AA6739B12A3B40270040A062 /* Project object */ = {
			isa = PBXProject;
			attributes = {
				BuildIndependentTargetsInParallel = 1;
				LastSwiftUpdateCheck = 1420;
				LastUpgradeCheck = 1420;
				TargetAttributes = {
					AA6739B82A3B40270040A062 = {
						CreatedOnToolsVersion = 14.2;
						LastSwiftMigration = 1420;
					};
				};
			};
			buildConfigurationList = AA6739B42A3B40270040A062 /* Build configuration list for PBXProject "swiftui-test-env" */;
			compatibilityVersion = "Xcode 14.0";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = AA6739B02A3B40270040A062;
			productRefGroup = AA6739BA2A3B40270040A062 /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				AA6739B82A3B40270040A062 /* swiftui-test-env */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		AA6739B72A3B40270040A062 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				AA6739E82A3B89140040A062 /* Assets.xcassets in Resources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		AA6739B52A3B40270040A062 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				AA6739D42A3B502A0040A062 /* swiftui_test_envApp.swift in Sources */,
				AA6739D62A3B52350040A062 /* IndexView.swift in Sources */,
<#list pages as page>
	<#assign pageName = page.uri?substring(page.uri?last_index_of("/") + 1)>
<#--				${page.hash!''} /* ${swift.nameType(pageName)}View.swift in Sources */,-->
</#list>
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin XCBuildConfiguration section */
		AA6739C52A3B40290040A062 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				GCC_C_LANGUAGE_STANDARD = gnu11;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = (
					"DEBUG=1",
					"$(inherited)",
				);
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 16.2;
				MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
				MTL_FAST_MATH = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = iphoneos;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
			};
			name = Debug;
		};
		AA6739C62A3B40290040A062 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				GCC_C_LANGUAGE_STANDARD = gnu11;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 16.2;
				MTL_ENABLE_DEBUG_INFO = NO;
				MTL_FAST_MATH = YES;
				SDKROOT = iphoneos;
				SWIFT_COMPILATION_MODE = wholemodule;
				SWIFT_OPTIMIZATION_LEVEL = "-O";
				VALIDATE_PRODUCT = YES;
			};
			name = Release;
		};
		AA6739C82A3B40290040A062 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
				CLANG_ENABLE_MODULES = YES;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_ASSET_PATHS = "\"./Preview Content\"";
				DEVELOPMENT_TEAM = H6X9G3CYFJ;
				ENABLE_PREVIEWS = YES;
				GENERATE_INFOPLIST_FILE = YES;
				INFOPLIST_KEY_UIApplicationSceneManifest_Generation = YES;
				INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
				INFOPLIST_KEY_UILaunchScreen_Generation = YES;
				INFOPLIST_KEY_UISupportedInterfaceOrientations = UIInterfaceOrientationPortrait;
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown";
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = "biz.doublegsoft.stdbiz.swiftui-test-env";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_OBJC_BRIDGING_HEADER = "";
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Debug;
		};
		AA6739C92A3B40290040A062 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
				CLANG_ENABLE_MODULES = YES;
				CODE_SIGN_STYLE = Automatic;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_ASSET_PATHS = "\"./Preview Content\"";
				DEVELOPMENT_TEAM = H6X9G3CYFJ;
				ENABLE_PREVIEWS = YES;
				GENERATE_INFOPLIST_FILE = YES;
				INFOPLIST_KEY_UIApplicationSceneManifest_Generation = YES;
				INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents = YES;
				INFOPLIST_KEY_UILaunchScreen_Generation = YES;
				INFOPLIST_KEY_UISupportedInterfaceOrientations = UIInterfaceOrientationPortrait;
				INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad = "UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown";
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/Frameworks",
				);
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = "biz.doublegsoft.stdbiz.swiftui-test-env";
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_OBJC_BRIDGING_HEADER = "";
				SWIFT_VERSION = 5.0;
				TARGETED_DEVICE_FAMILY = "1,2";
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		AA6739B42A3B40270040A062 /* Build configuration list for PBXProject "swiftui-test-env" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				AA6739C52A3B40290040A062 /* Debug */,
				AA6739C62A3B40290040A062 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		AA6739C72A3B40290040A062 /* Build configuration list for PBXNativeTarget "swiftui-test-env" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				AA6739C82A3B40290040A062 /* Debug */,
				AA6739C92A3B40290040A062 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = AA6739B12A3B40270040A062 /* Project object */;
}