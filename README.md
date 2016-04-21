# seasonal
Which is the nearest season in 12 tone seasonal colour analysis? Which is the season you will most likely be able to sneak in? Naturally, your own season is the best, but sometimes, that is not an option. And which might be possibly your kryptonite?

## How to install
Well, you need Erlang, of course. Then open up your terminal in the folder, where the source file 'seasonal.erl' is contained in. Start the Erlang interpreter with `erl`, consult the file `c(seasonal).` and you're done.

## How to use
The program has three public methods, that can be used as follows:


`seasonal:closeness(dark_autumn).` prints out all the other season and their closeness value in relation to the given season (here Dark Autumn).

`seasonal:season(dark_autumn).` prints out the attributes for the given season (here Dark Autumn).

`seasonal:closenessAll().` prints out all the seasons mapped to their closest neighbour.

