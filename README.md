# NAME

WebService::Songkick - A simple and fast interface to the Songkick API

# SYNOPSIS

    use WebService::Songkick;

    my $songkick = new WebService::Songkick(apikey => 'YOUR_API_KEY');

# DESCRIPTION

The module provides a simple interface to the Songkick API. To use this module, you must first sign up at http://www.songkick.com/developer/ to receive an API key.

# METHODS

These methods usage: [http://www.songkick.com/developer/](http://www.songkick.com/developer/)

### artists\_calendar

my $data = $songkick->artists\_calendar(331163);
$data = $songkick->artists\_calendar('mbid:65f4f0c5-ef9e-490c-aee3-909e7ae6b2ab');

### venues\_calendar

my $data = $songkick->venues\_calendar(6239);

### metro\_areas\_calendar

my $data = $songkick->metro\_areas\_calendar(30717);

### users\_calendar

my $data = $songkick->users\_calendar('hondallica', reason => 'tracked\_artist');

### events

my $data = $songkick->events(artist\_name => 'Metallica');

### search\_artists

my $data = $songkick->search\_artists(query => 'Metallica');

### search\_venues

my $data = $songkick->search\_venues(query => 'Tokyo');

### search\_locations

my $data = $songkick->search\_locations(query => 'Tokyo');

# SEE ALSO

http://www.songkick.com/developer/

# LICENSE

Copyright (C) Hondallica.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Hondallica <hondallica@gmail.com>
