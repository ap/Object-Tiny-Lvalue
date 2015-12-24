requires 'perl', '5.006';
requires 'strict';
requires 'warnings';

on test => sub {
	requires 'Test::Fatal';
	requires 'Test::Lives';
	requires 'Test::More', '0.88';
	requires 'lib';
	requires 'parent';
};

# vim: ft=perl
