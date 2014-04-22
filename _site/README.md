Mapless
=======

*Obscenely simple persistence for Smalltalk.* Mapless is a small framework for storing objects in a key->data fashion (i.e.: noSQL databases) without requiring any kind of object-data map.  So far only MongoDB is supported. And Redis can be used for reactivity and cache joy.

###Motivation
> "I wanted to persist objects with extremely *low friction* and extremely *low maintenance* and great *scaling* and *availability* capabilities so Mapless is totally biased towards that. This framework is what I came up with after incorporating my experience with [Aggregate](https://github.com/sebastianconcept/Aggregate)." ~ [Sebastian](http://about.me/sebastianconcept)

*There is no spoon...*

*There is no object-relational impedance...*

*There is no instVars...*

*Only persistence*.

###Loading it in your image 

Take your open image and click for a **menu**, then **tools**, then **Configuration Browser** and search for **Mapless**. Click **Install Stable Version**

Or...

Use this snippet to load it into your [Pharo](http://www.pharo-project.org/home)* image:

    Gofer it 
		smalltalkhubUser: 'Pharo'
		project: 'MetaRepoForPharo30'; 
		package: 'ConfigurationOfMapless';
		load.
	
    (Smalltalk at: #ConfigurationOfMapless) load

###How does it look?

You can store  and retrieve your Mapless models on MongoDB like a breeze. Here is a couple of snippets used while developing [tasks](http://tasks.flowingconcept.com)

####Getting the connection

    odb := MongoPool instance databaseAt: 'Reactive'.
    
####Create a new model

Just subclass MaplessModel. Here we use a RTask model:

In Mapless you do things using a #do: closure which Mapless uses to automatically discern which MongoDB database and collection has to be used. It also will know if it needs to do an insert or an update. As a bonus, you get the collection *and* the database created lazily. 

Want to save something? Zero bureaucracy, just tell that to the model:



    	task 
    		deadline: Date tomorrow; 
    		notes: 'Wonder how it feels to use this thing, hmm...';
    		save].

Of course you do:

      anAlert := RAlert new 
      				duration: 24 hours;
      				message: 'You will miss the target!';
      				save.
    	task 
    		alert: anAlert;
    		save].



    odb do:[task alert message].   

    odb do:[task alert class = MaplessReference].  "<- true"   

    odb do:[task alert description].  "<- 'You will miss the target!'"   

####Persisting a different model

So you now need to store a different kind of models, say List or User or anything, how you proceed? 

This is what you do with Mapless:

1. Create a subclass for them
2. <del>Know what attributes they will need in advance</del>
3. <del>Create its attributes' instVars</del>
4. <del>Make accessors for them</del>
5. <del>Elegantly map them so it all fits in the database</del>
6. Profit

###How does it look? on Redis

Redis is interesting for:

1. **Caching**. It will hold the data in RAM so you get great response times.
2. **Reactivity**. Mapless uses Redis [PUB/SUB](http://redis.io/topics/pubsub) feature to observe/react models among N Pharo worker images enabling [horizontal scaling](http://en.wikipedia.org/wiki/Scalability#Horizontal_and_vertical_scaling).

Here is a workspace for Redis based Mapless models:

    redis := RedisPool instance.
    guy := MaplessRedisDummyPerson new
    redis do:[:c| guy save].
    redis do:[:c| (MaplessRedisDummyPerson findAt: '38skolpqv0y9lazmk772hmsed') lastName].

###State

This code is considered alpha. Check its tests. Contribute!

###Contributions

...are *very* welcomed, send that push request and hopefully we can review it together.

###Direction?

1. We would love to see more and better tests and iterate the reactive features so you can ultimately get an a model in one image being observed in regard to one event by something in another image and that something reacting upon that event. Broadcast and multicast of events would be also a nice feat and not too hard to do. Have design suggestions? Let's have a chat!
2. We actually are starting to think [Amber](http://amber-lang.net) and [localStorage](http://en.wikipedia.org/wiki/Web_storage) but that's more hush hush at this point. Oh gee! [we already](https://www.youtube.com/watch?v=ZDC1N5wYsMg) blown it!

###*Pharo Smalltalk
Getting a fresh Pharo Smalltalk image and its virtual machine is as easy as running in your terminal:
 
    wget -O- get.pharo.org/30+vm | bash

_______

MIT - License

2014 - [sebastian](http://about.me/sebastianconcept)

o/