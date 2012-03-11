#!/usr/bin/perl -w

use strict;
use lib qw(lib);
package Everything::node::setting;
use base qw(Everything::node::node);

sub node_id_equivs
{
	my ($this) = @_;
	return ["setting_id",@{$this->SUPER::node_id_equivs()}];
}

sub import_skip_update
{
	my ($this) = @_;
	# hrstats, Room Topics
	return [1373661, 1149799,@{$this->SUPER::import_skip_update()}]
}

1;
