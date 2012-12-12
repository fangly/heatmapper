use inc::Module::Install;

name     'heatmapper';
all_from 'script/heatmapper';
license  'gpl3'; # Module::Install 1.04 does not parse the GPL version number

resources
   homepage   'http://github.com/fangly/heatmapper';
   bugtracker 'http://github.com/fangly/heatmapper/issues';
   repository 'http://github.com/fangly/heatmapper';

# List of dependencies
build_requires  'Test::More'                       =>  0;
requires        'Getopt::Euclid'                   => '0.3.4';
requires        'List::Util'                       =>  0;
requires        'Statistics::R'                    =>  0.27;
author_requires 'Module::Install'                  =>  0;
author_requires 'Module::Install::AuthorRequires'  =>  0;
author_requires 'Module::Install::AutoLicense'     =>  0;
author_requires 'Module::Install::AutoManifest'    =>  0;
author_requires 'Module::Install::PodFromEuclid '  =>  0;
author_requires 'Module::Install::ReadmeFromPod'   =>  0.16;
requires_external_bin 'R';

# Install dependencies
auto_install;

# Extra scripts to install
install_script 'script/heatmapper';

# Generate MANIFEST file
auto_manifest();

# Generate Makefile and META.yml files
WriteAll;

# Generate the LICENSE file
auto_license();

# Generate the README and manpage files from the POD docs
auto_doc();


#--------- UTILS --------------------------------------------------------------#

sub auto_doc {
   print "*** Building doc...\n";
   # Generate script/heatmapper.pod
   pod_from 'script/heatmapper';
   my $file = 'script/heatmapper.pod';
   my $man_dir = 'man';
   if (not -d $man_dir) {
      mkdir $man_dir or die "Could not write folder $man_dir:\n$!\n";
   }
   my $clean   = 1;
   readme_from $file, { clean => $clean, format => 'txt', output_file => 'README' };
   readme_from $file, { clean => $clean, format => 'htm', output_file => 'README.htm' };
   readme_from $file, { clean => $clean, format => 'man', output_file => "$man_dir/heatmapper.1" };
   return 1;
}
