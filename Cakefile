fs  = require("fs")
path  = require("path")
spawn = require("child_process").spawn
hamlc = require("haml-coffee") 

ROOT_PATH	= __dirname
JAVASCRIPTS_PATH = path.join(ROOT_PATH,'/build')
COFFEESCRIPTS_PATH = path.join(ROOT_PATH,'/src')

log = (data)->
	console.log data.toString().replace("\n","")


runCmd = (cmd,args,exit_cb)-> 
	ps = spawn(cmd,args)
	ps.stdout.on("data",log)
	ps.stderr.on("data",log)
	ps.on 'exit',(code)->
		if(code!=0)
			log("failed")
		else
			exit_cb?()

is_coffee_available= ->
	present = false
	path_variable = process.env.PATH
	path_variable.split(":").forEach (value,index,array) ->
		present ||= path.exists("#{value}/coffee")
	present


if_coffee = (callback)->	
	unless is_coffee_available
		console.log("Coffeescript not found ! Install and try again")
		exit(-1)
	else
		callback()

task 'build-haml',"Building haml templates" , ->
	if_coffee ->
		runCmd(path.join(path.dirname(require.resolve("haml-coffee")),"bin/haml-coffee"),["-i","src/templates","-o","build/templates.js","-b","views"])
task 'build-saas',"Building saas" , ->
	runCmd("compass",["compile", "--sass-dir", "sass", "--css-dir", "styles"])

task 'build' ,"Building the app" , ->
	if_coffee ->
		runCmd("coffee",["--output",JAVASCRIPTS_PATH,"--compile",COFFEESCRIPTS_PATH],->
			invoke('build-haml')
			invoke('build-saas'))

task 'clean_build' ,"clean and rebuild" , ->
	console.log("Cleaning files...")
	runCmd("rm",["-rf","*","build/"])
	console.log("Cleaning files complete.")
	console.log("Building")
	invoke('build')

task 'watch',"Watching your Coffee script files",->
	if_coffee ->
		runCmd("coffee",["--output",JAVASCRIPTS_PATH,"--watch",COFFEESCRIPTS_PATH])
