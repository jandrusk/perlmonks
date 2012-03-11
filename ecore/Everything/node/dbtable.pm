#!/usr/bin/perl -w

use strict;
use lib qw(lib);
use Clone qw(clone);
package Everything::node::dbtable;
use Everything::node::node;
use base qw(Everything::node::node);

sub node_xml_prep
{
	my ($this, $N, $dbh, $options) = @_;
	my $NODE = Clone::clone($N);
	
	my $password_string = " -p$$options{password}";

	if($$options{password} eq "")
	{
		$password_string = "";
	}		

	my $sth = $dbh->prepare("SHOW CREATE TABLE $$NODE{title}");
	$sth->execute();
	my $create_table_statement;

	if(my $result = $sth->fetchrow_arrayref())
	{
		$create_table_statement = $result->[1];
	}

	#my $create_table_statement = `mysqldump --skip-add-drop-table --skip-add-locks --skip-disable-keys --skip-set-charset --skip-comments -d -u $$options{user}$password_string $$options{database} $$NODE{title}`;
	if(not defined($create_table_statement))
	{
		die "Could not get create table statement for dbtable $$NODE{title}";
	}

	$NODE->{_create_table_statement} = $create_table_statement;
	return $this->SUPER::node_xml_prep($NODE, $dbh);
}

sub xml_to_node_post
{
	my ($this, $N) = @_;
	delete $N->{_create_table_statement};
	return $this->SUPER::xml_to_node_post($N);
}

sub import_no_consider
{
	my ($this) = @_;
	return ["_create_table_statement", $this->SUPER::import_no_consider()];
}

1;
