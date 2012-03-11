#!/usr/bin/perl -w

use strict;
use lib qw(lib);
package Everything::node::room;
use base qw(Everything::node::document);

sub node_xml_prep
{
	my ($this, $NODE, $dbh) = @_;

	# Strip old windows line endings
	$NODE->{criteria} = $this->_clean_code($NODE->{criteria});
	return $this->SUPER::node_xml_prep($NODE, $dbh);
}

sub node_id_equivs 
{
	my ($this) = @_;
	return ["roomdata_id", @{$this->SUPER::node_id_equivs()}];
}

sub xml_no_store
{
	my ($this) = @_;
	return ["lastused_date",@{$this->SUPER::xml_no_store()}];
}

1;
