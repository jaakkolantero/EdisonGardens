var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var http = require('http');

//EDISON
//var mraa = require('mraa'); //require mraa
//console.log('MRAA Version: ' + mraa.getVersion()); //write the mraa version to the Intel XDK console
var ledState = true;


var routes = require('./routes/index');
var users = require('./routes/users');
var about = require('./routes/about');
var dashboard = require('./routes/dashboard');
var blink = require('./routes/blink');
var twitter = require('./routes/twitter');

var app = express();
var server = app.listen(8081);
var io = require('socket.io').listen(server);

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', routes);
app.use('/users', users);
app.get('/about', about.about);
app.get('/dashboard', dashboard.dashboard);
app.get('/blink', blink.blink);
app.get('/twitter', twitter.twitter);

//EDISON
//var myOnboardLed = new mraa.Gpio(13); //LED hooked up to digital pin 13 (or built in pin on Intel Galileo Gen2 as well as Intel Edison)
//myOnboardLed.dir(mraa.DIR_OUT); //set the gpio direction to output

io.on('connection', function (client){ 
  // new client is here!
	setInterval(function(){
        client.emit('date', {'date': new Date()});
    }, 1000);
	
	//recieve client data
	  client.on('client_data', function(data){
	    process.stdout.write(data.letter);
	  });
	  
	  var led_status = "Led is OFF!";

	  client.on('led toggle', function (data) {
	        if (data.data === true) {
	        	console.log('Led state: ' + data.data);
	        	//EDISON
	        	//myOnboardLed.write(1);
	        	
	        } else {
	        	console.log('Led state: ' + data.data);
	        	//EDISON
	        	//myOnboardLed.write(0);
	        }
	  }); 
});

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});

periodicActivity();

function periodicActivity()
{
	//EDISON
	//myOnboardLed.write(ledState?1:0); //if ledState is true then write a '1' (high) otherwise write a '0' (low)
	ledState = !ledState; //invert the ledState
	setTimeout(periodicActivity,1000); //call the indicated function after 1 second (1000 milliseconds)
}


module.exports = app;
