package WebService::Songkick;
use JSON::XS;
use Cache::LRU;
use Net::DNS::Lite;
use Furl;
use URI;
use URI::QueryParam;
use Carp;
use Moo;
use Data::Dumper;
use namespace::clean;
our $VERSION = "0.01";


$Net::DNS::Lite::CACHE = Cache::LRU->new( size => 512 );

has 'api_key' => (
    is => 'rw',
    isa => sub { $_[0] },
    required => 1,
    default => sub { $ENV{SONGKICK_API_KEY} },
);

has 'http' => (
    is => 'rw',
    required => 1,
    default  => sub {
        my $http = Furl::HTTP->new(
            inet_aton => \&Net::DNS::Lite::inet_aton,
            agent => 'WebService::Songkick' . $VERSION,
            headers => [ 'Accept-Encoding' => 'gzip',],
        );
        return $http;
    },
);

sub artists_calendar {
    my ($self, $id) = @_;
    return $self->request("artists/$id/calendar.json");
}

sub venues_calendar {
    my ($self, $id) = @_;
    return $self->request("venues/$id/calendar.json");
}

sub metro_areas_calendar {
    my ($self, $id) = @_;
    return $self->request("metro_areas/$id/calendar.json");
}

sub users_calendar {
    my ($self, $id, %param) = @_;
    return $self->request("users/$id/calendar.json", \%param);
}

sub events {
    my ($self, %param) = @_;
    return $self->request('events.json', \%param);
}

sub search_artists {
    my ($self, %param) = @_;
    return $self->request('search/artists.json', \%param);
}

sub search_venues {
    my ($self, %param) = @_;
    return $self->request('search/venues.json', \%param);
}

sub search_locations {
    my ($self, %param) = @_;
    return $self->request('search/venues.json', \%param);
}

sub request {
    my ( $self, $path, $query_param ) = @_;

    my $query = URI->new;
    $query->query_param( 'apikey', $self->api_key );
    map { $query->query_param( $_, $query_param->{$_} ) } keys %$query_param;

    my ($minor_version, $status_code, $message, $headers, $content) = 
        $self->http->request(
            scheme => 'http',
            host => 'api.songkick.com',
            path_query => "api/3.0/${path}$query",
            method => 'GET',
        );

    my $data = decode_json( $content );
    if ( $status_code != 200 ) {
        confess $data->{resultsPage}{error}{message};
    } else {
        return $data;
    }
}


1;
__END__

=encoding utf-8

=head1 NAME

WebService::Songkick - A simple and fast interface to the Songkick API

=head1 SYNOPSIS

    use WebService::Songkick;

    my $songkick = new WebService::Songkick(apikey => 'YOUR_API_KEY');


=head1 DESCRIPTION

The module provides a simple interface to the Songkick API. To use this module, you must first sign up at http://www.songkick.com/developer/ to receive an API key.

=head1 METHODS

These methods usage: L<http://www.songkick.com/developer/>

=head3 artists_calendar

    my $data = $songkick->artists_calendar(331163);
    $data = $songkick->artists_calendar('mbid:65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab');

=head3 venues_calendar

    my $data = $songkick->venues_calendar(6239);

=head3 metro_areas_calendar

    my $data = $songkick->metro_areas_calendar(30717);

=head3 users_calendar

    my $data = $songkick->users_calendar('hondallica', reason => 'tracked_artist');

=head3 events

    my $data = $songkick->events(artist_name => 'Metallica');

=head3 search_artists

    my $data = $songkick->search_artists(query => 'Metallica');

=head3 search_venues

    my $data = $songkick->search_venues(query => 'Tokyo');

=head3 search_locations

    my $data = $songkick->search_locations(query => 'Tokyo');

=head1 SEE ALSO

http://www.songkick.com/developer/

=head1 LICENSE

Copyright (C) Hondallica.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Hondallica E<lt>hondallica@gmail.comE<gt>

=cut

