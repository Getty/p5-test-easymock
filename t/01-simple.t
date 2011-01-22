use strict;
use warnings;
use Test::More;
use Test::EasyMock;

my $object = new_mock('MyClass','MyParentClass','MyParentParentClass',{
	value => 'value',
	key => 'key',
},[
	[ 'test1', [], [ 'test' ] ],
	[ 'test2', [ 'test', 'test2' ], [ 'test2', 'test1' ] ],
	[ 'test3', [ 'test3', 'test2', 'test1' ], [ 'test3', 'test2', 'test1' ] ],
]);

use Data::Dumper;

print Dumper $object;

$object->test;
# $object->blub('test1');

my $object2 = new_mock('MyClass','MyParentClass','MyParentParentClass',{
	value => 'value',
	key => 'key',
},[
	[ 'test1', [], [ 'test' ] ],
]);
print Dumper $object2;

done_testing;
