#import "File";
#import "BuildCpp";
#import "Compiler";
#import "Basic";

#run {
	set_build_options_dc( .{do_output = false} );

	srcs := enum_cpp_files( "meshoptimizer/src" );
	defer free_cpp_files( srcs );

	#if OS == .WINDOWS {
		path_prefix := "win";
		extra := string.[];
	} else {
		#if OS == .LINUX {
			path_prefix := "linux";
		}
		#if OS == .MACOS {
			path_prefix := "macos";
		}
		extra := string.[];
	}
	
	make_directory_if_it_does_not_exist( path_prefix );
	libname := tprint( "%/meshoptimizer", path_prefix );

	print("Building static library:\n");
	build_cpp_static_lib( libname, ..srcs );
};
