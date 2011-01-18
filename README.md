# Share39
## Personal music sharing server 
### (aka) sinatra app to share and stream mp3s 
others formats will be added soon...


## Installation

- install rvm
- install ruby-1.9.2-rc2

- gem install thin bundler

- install hombrew 
- brew install id3lib

- bundle install
- rake install
- cd lib; thin -C config/thin.yml start



## launching

thin -C config/thin.yml start

DEV
shotgun --server=thin --port=3939

shotgun --server=thin --port=3939 -o local_ip        (ifconfig/ipconfig to get it)
shotgun --server=thin --port=3939 -o 0.0.0.0

---

### notes to myself ^^

gem build share39.gemspec; gem install share39-0.1.1.gem 
gem install share39-0.1.1
irb

---

oops, random toughts down there: 

GuitarHero.ancestors.include?  Macross7 #=> true 

From macross 7 song

http://www.youtube.com/watch?v=pwDENOpP8fU - 4:00

I bring my fading burning heart along with my song 
because it can't be passed on by words

look at each other and communicate with your warm heart and soul