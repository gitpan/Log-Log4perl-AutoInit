use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Log::Log4perl::AutoInit',
    AUTHOR           => q{Chris Travers <christravers@binary.com>},
    VERSION_FROM     => 'lib/Log/Log4perl/AutoInit.pm',
    ABSTRACT_FROM    => 'lib/Log/Log4perl/AutoInit.pm',
    LICENSE          => 'Artistic_2_0',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        'Log::Log4perl' => 0,
        #'ABC'              => 1.6,
        #'Foo::Bar::Module' => 5.0401,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Log-Log4perl-AutoInit-*' },
);
