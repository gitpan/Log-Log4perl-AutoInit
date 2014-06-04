package Log::Log4perl::AutoInit;

use 5.008;
use strict;
use warnings FATAL => 'all';
use Log::Log4perl;

use base qw( Exporter );                                                        
our @EXPORT_OK = qw( init_log4perl get_logger );


=head1 NAME

Log::Log4perl::AutoInit - Log4Perl with autoinitialization.

=head1 VERSION

Version 1.0.0

=cut

our $VERSION = '1.0.0';


=head1 SYNOPSIS

use Log::Log4perl::AutoInit qw(get_logger);
Log::Log4perl::AutoInit->set_config('path/to/l4p.conf');

get_logger->warning('l4p initialized and warning logged');

=head1 DESCRIPTION

This module provides a simple wrapper around Log::Log4perl for cases where 
initialization may need to be delayed until a statup process is complete, but 
where configuration may need to be registered before that point.  In essence
it provides a way to delay logger initialization until the logger is actually
needed or used.

=head1 EXPORT

=head2 get_logger


=head1 SUBROUTINES/METHODS

=head2 set_config

This API sets the configuration for subsequent logger initialization.  This 
only caches the config and does no initialization itself.

=cut

my $l4p_config;

sub set_config {
    $l4p_config = shift;
    $l4p_config = shift if $l4p_config eq __PACKAGE__;
}

=head2 set_default_category

Sets the default category for all future loggers.  If not found the callers'
module name is used.  To unset pass in undef.

=cut

my $default_category;

sub set_default_category {
    $default_category = shift;
    $default_category = shift if $default_category eq __PACKAGE__;
}

=head2 get_logger

Initializes, if necessary, and returns a logger with the identical syntax to
Log4perl::get_logger()

=cut

sub get_logger {
    _init();
    my $category = $_[0];
    $category = $default_category unless defined $category;
    $category = (caller)[0] unless defined $category;
    return Log::Log4perl::get_logger($category);
}

my $initialized = 0; # move to state when we can drop 5.8 support

=head2 initialize_now(bool $reinitialize);

This initializes Log4perl.  If $reinitialize is set, it allows Log4perl to be 
explicitly reinitialized.

=cut

sub initialize_now {
   my $re_init = shift;
   $re_init = shift if $re_init eq __PACKAGE__;
   $initialized = 0 if $re_init;
    _init();
}

# private method for for initialization

sub _init {
    return if $initialized;
    ++$initialized;
    Log::Log4perl->init($l4p_config);
}


=head1 AUTHOR

Binary.com, C<< <perl@binary.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-log-log4perl-autoinit at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Log-Log4perl-AutoInit>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Log::Log4perl::AutoInit


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Log-Log4perl-AutoInit>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Log-Log4perl-AutoInit>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Log-Log4perl-AutoInit>

=item * Search CPAN

L<http://search.cpan.org/dist/Log-Log4perl-AutoInit/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE 

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Log::Log4perl::AutoInit
