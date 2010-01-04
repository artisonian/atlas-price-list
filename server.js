var sys = require('sys'),
	repl = require('repl'),
	dj = require('./djangode');
	// underscore = require('./underscore')._;

var PORT = 8000;
var message_queue = new process.EventEmitter();

/*
(function() {
	setInterval(function() {
		message_queue.emit('update', {message:'test'});
	}, 5 * 1000);
})();
*/

var app = dj.makeApp([
	['^/test$', function(req, res) {
		var listener = message_queue.addListener('update', function(msg) {
			dj.respond(res, JSON.stringify(msg), 'application/json');
			message_queue.removeListener('update', listener);
			clearTimeout(timeout);
		});
		var timeout = setTimeout(function() {
			message_queue.removeListener('update', listener);
			dj.respond(res, JSON.stringify({message:'done'}), 'application/json');
		}, 30 * 1000);
	}],
	['^/(Frameworks/.*)$', dj.serveFile],
	['^/(Resources/.*)$', dj.serveFile],
	['^/$', function(req, res) {
		dj.serveFile(req, res, 'index.html');
	}],
	['^/(.*)$', dj.serveFile]
]);

dj.serve(app, PORT);
repl.start('> '); // Read-Eval-Print loop
repl.scope.sendTest = function() {
	message_queue.emit('update', {message:'test'});
};
repl.scope.newPriceItem = function(name, price) {
	if (!name || !price) {
		return;
	}
	message_queue.emit('update',{results:[{'name':name,'price':price}]})
};
// repl.scope.underscore = underscore;