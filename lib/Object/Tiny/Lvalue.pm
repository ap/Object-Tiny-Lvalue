use 5.006; use strict; use warnings;

package Object::Tiny::Lvalue;

our $VERSION = '1.084';

sub import {
	return unless shift eq __PACKAGE__;
	my $pkg = caller;
	eval join "\n", (
		"package $pkg;",
		'our @ISA = "Object::Tiny::Lvalue" unless @ISA;',
		map {
			defined and /\A[^\W\d]\w*\z/ or die "Invalid accessor name '$_'";
			"sub $_ : lvalue { \$_[0]->{$_} }";
		} @_
	);
	die "Failed to generate $pkg" if $@;
	return 1;
}

sub new {
	my $class = shift;
	bless { @_ }, $class;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Object::Tiny::Lvalue - minimal class builder with lvalue accessors

=head1 SYNOPSIS

Define a class:

  package Foo;
  use Object::Tiny::Lvalue qw( bar baz );
  1;

Use the class:

  my $object = Foo->new( bar => 1 );
  printf "bar is %s\n", $object->bar;
  $object->bar = 2;
  printf "bar is now %s\n", $object->bar;

=head1 DESCRIPTION

This is a clone of L<Object::Tiny|Object::Tiny>, but adjusted to create accessors that return lvalues.

You probably want to use L<Object::Properties|Object::Properties> instead.

=cut
