Chatminion - an Office chat assistant
=====================================

*The following instructions  are to people who want to hack the chatminion .The production version is available here*


I m sure , Your are here to hackaway this chatminion project . I m glad and happy .

The development stack of chatminion is the following

##Client side

* Chrome packaged app API'S(not chrome extension)

* Coffeescript 

* Backbone JS

* HAML

* HTML + CSS

* Web RTC for video calls support

* PostgreSQL
>postgresql is used , because heroku primarily supports postgres.You are free to use any database

##Server side
The server side is handled by **Rails stack** . There is nothing much to code in the server side as there is almost **zero server over-head** (see the message flow).
You have to pull that too for development . [chatminion-heroku-app](https://github.com/dineshswamy/chatminion-heroku-app)

Familiarity with the following technologies will be helpful 
IndexedDB , WebRTC(although the complexity is hidden by PEERJS)

Proficiency with the above stack is required to build on top of this . Absolute begginer , can easily understand what is 
written , you dont need to be a PRO with these technologies(neither was I).
The code is not heavily commented although i m working on to do that . you can drop me a mail , in case you need them . i m happy to answer . 

The messaging mechanism is described below

		[	PICTURE	  ]

Instructions to setup development environment 

1) Install the following depending on your Operating system	
```
	* Coffeescript
	* Haml-coffee
	* rails 4.0 
	* postgreSQL(optional, choose any DB of your choice)
```

2) Pull the repos


[chatminion-heroku-app](https://github.com/dineshswamy/chatminion-heroku-app)


[chatminion-chrome-app](https://github.com/dineshswamy/chatminion-chrome-app)

3)
```
   cd chatminion-chrome-app/app
   cake build
   cake watch
   (whenever you change HAML templates , make sure do a cake build)
```
4) 
```
   cd chatminion-heroku-app
   rails server
```

5) Install the app  into google-chrome  via  **developer-mode**

6) **Congratulations** , you ve pulled the properly .

