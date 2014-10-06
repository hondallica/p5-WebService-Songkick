use strict;
use Test::More 0.98;

use_ok $_ for qw(
    WebService::Songkick
);

my $songkick = new WebService::Songkick;
isa_ok $songkick, 'WebService::Songkick';

my $data = $songkick->artists_calendar(331163);
my $data = $songkick->artists_calendar('mbid:65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab');
my $data = $songkick->venues_calendar(6239);
my $data = $songkick->metro_areas_calendar(30717);
my $data = $songkick->users_calendar('admin', reason => 'attendance');
my $data = $songkick->users_calendar('hondallica', reason => 'tracked_artist');
my $data = $songkick->events(artist_name => 'Metallica');
my $data = $songkick->search_artists(query => 'Metallica');
my $data = $songkick->search_venues(query => 'Tokyo');
my $data = $songkick->search_locations(query => 'Tokyo');


done_testing;

