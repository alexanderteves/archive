#!/perl

# Perl ToDo Manager - A todo.txt manager written in Perl.
# Copyright (C) 2009  Alexander Teves
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

# Perl ToDo Manager
# Version :			0.1
# Author :			Alexander Teves
# Released :		2009-04-13
# Last updated :	2009-04-13
# License :			GPLv2, http://www.gnu.org/licenses/gpl-2.0.html

use File::Copy;
use Switch;

# When using CMD.EXE in Windows and having installed this package, uncomment for colors.
#use Win32::Console::ANSI;

use Term::ANSIColor;

# Your desired directory:
$file_path = "D:/Eigene Dateien/Dokumente/";

# Stuff:
$Term::ANSIColor::AUTORESET = 1;
$line = 1;
$counter = 0;

# Colors:
$color_a = "bold red";
$color_b = "bold yellow";
$color_c = "bold green";
$color_else = "cyan";
$color_done = "bold black";

switch($ARGV[0]) {									#Decide what to do, depending on commandline arguments.
	case ["add", "a"] {
		foreach (1 .. $#ARGV) {						#Creates 1 string from multiple passed arguments.
			$string = $string . " " . $ARGV[$_];
		}
		substr ($string, 0, 1, "");
		&add($string);
	}
	
	case ["append", "app"] {
		if ($ARGV[1] =~ /^\d+$/) {
			foreach (2 .. $#ARGV) {
				$string = $string . " " . $ARGV[$_];
			}
			#substr ($string, 0, 1, "");
			&app($ARGV[1], $string);
		} else {
			print ("\nError! Example: todo.pl app 12 some text to append\n");
		}
	}
	
	case "archive" {&archive;}
	
	case ["del", "rm"] {
		if ($ARGV[1] =~ /^\d+$/) {					#RegExp checks if digit (and only digit) is given for line number.
			&del ($ARGV[1]);
		} else {
			print ("\nError! Example: todo.pl del 12\n");
		}
	}
	
	case ["done", "do"] {
		if ($ARGV[1] =~ /^\d+$/) {
			&do ($ARGV[1]);
		} else {
			print ("\nError! Example: todo.pl do 12\n");
		}
	}
	
	case ["list", "ls"] {&ls ($ARGV[1])}
	
	case ["prepend", "pre"] {
		if ($ARGV[1] =~ /^\d+$/) {
			foreach (2 .. $#ARGV) {
				$string = $string . $ARGV[$_] . " ";
			}
			#substr ($string, 0, 1, "");
			&pre($ARGV[1], $string);
		} else {
			print ("\nError! Example: todo.pl pre 12 some text to prepend\n");
		}
	}

	case ["pri", "p"] {
		if ($ARGV[1] =~ /^\d+$/ and $ARGV[2] =~ /^[a-zA-Z]+$/) {	#RegExp checks if digit is given for line number and letter for pririty.
			&pri ($ARGV[1], $ARGV[2]);
		} else {
			print ("\nError! Example: todo.pl pri 12 A\n");
		}
	}
	
	case ["replace", "rep"] {
		if ($ARGV[1] =~ /^\d+$/) {
			foreach (2 .. $#ARGV) {
				$string = $string . " " . $ARGV[$_]
			}
			substr ($string, 0, 1, "");
			&rep ($ARGV[1], $string);
		} else {
			print ("\nError! Example: todo.pl rep 12 some new text\n");
		}
	}

	else {print ("\nNothing to do. Quit.\n");}
}

sub create_timestamp {								#Guess what. Creats a timestamp yearmonthday.
	($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst) = localtime(time);
	$year += 1900;
	$mon += 1;
	if ($mon < 10) {$mon = "0$mon"}
	if ($mday < 10) {$mday = "0$mday"}
	return "$year-$mon-$mday";
}

sub get_content {									#Read content of file, push in array and return that.
	copy($file_path . "todo.txt", $file_path . "todo.txt.bak");
	open (READ_FILE, $file_path . "todo.txt");
	while (<READ_FILE>) {
		chomp;
		push @array, $_;
	}
	close (READ_FILE);
	return @array;
}

sub add {											#Add line to file.
	open (APPEND_FILE, ">>" . $file_path . "todo.txt");
	print (APPEND_FILE "\L$_[0]\n");
	close (APPEND_FILE);
}

sub app {											#Append something to a specific line.
	@array = &get_content;
	open (WRITE_FILE, ">" . $file_path . "todo.txt");
	foreach $_(@array) {
		if ($line != $_[0]) {						#This checks if current line is the line to be manipulated. Used a lot.
			print (WRITE_FILE "$_\n");
		} else {
			print ("\nEdited task : $_\n");
			print (WRITE_FILE "$_" . "$_[1]\n");
		}
		$line++;
	}
	close (WRITE_FILE);
}

sub archive {										#Remove tasks marked as done and save in done.txt.
	@array = &get_content;
	open (WRITE_FILE, ">" . $file_path . "todo.txt");
	open (WRITE_DONE_FILE, ">>" . $file_path . "done.txt");
	foreach $_(@array) {
		if (/^x\s\d/) {								#RegExp checks if this task is done.
			print ("\nArchived : $_\n");
			print (WRITE_DONE_FILE "$_\n");
		} else {
			print (WRITE_FILE "$_\n");
		}
		$line++;
	}
	close (WRITE_FILE);
	close (WRITE_DONE_FILE);
}

sub del {											#Delete line from file.
	@array = &get_content;
	open (WRITE_FILE, ">" . $file_path . "todo.txt");
	foreach $_(@array) {
		if ($line != $_[0]) {
			print (WRITE_FILE "$_\n");
		} else {
			print ("\nEdited : $_\n");
		}
		$line++;
	}
	close (WRITE_FILE);
}

sub do {											#Mark a line as done.
	@array = &get_content;
	$timestamp = &create_timestamp;
	open (WRITE_FILE, ">" . $file_path . "todo.txt");
	foreach $_(@array) {
		if ($line != $_[0]) {
			print (WRITE_FILE "$_\n");
		} else {
			print ("\nEdited : $_\n");
			if (/^\([A-Z]\)/) {						#RegExp checks if there is a pririty flag set.
				substr ($_, 0, 3, "");					#If it is, remove it.
			}
			if (/^ /) {								#When priority flag is removed, whitespace remains between flag and task. This is removed here.
				substr ($_, 0, 1, "");
			}
			print (WRITE_FILE "x $timestamp $_\n");
		}
		$line++;
	}
	close (WRITE_FILE);
}

sub ls {											#ls file content.
	$today = &create_timestamp;	
	print ("\n");
	open (READ_FILE, $file_path . "todo.txt");
	while (<READ_FILE>) {
		if ($line < 10) {
			$line = "0" . $line;					#This makes 1 to 01 (for all values < 10) Just style. ;)
		}
		$my_hash{$line} = $_;
		$line = "$line" + 1;
	}
	@keys = sort {									#Sorts hashmap by value, not key (key = line no.).
		$my_hash{$a} cmp $my_hash{$b}
	} keys %my_hash;
	foreach $key (@keys) {
		$_ = "$key $my_hash{$key}";
		if ($_[0] eq "today") {
			if (/\!\s$today/) {							#RegExp filters ls by given commandline argument.
				switch (substr ($_,3,3)) {
					case (/^\([aA]\)/) {print (colored ($_, $color_a))}
					case (/^\([bB]\)/) {print (colored ($_, $color_b))}
					case (/^\([cC]\)/) {print (colored ($_, $color_c))}
					case (/^x\s\d/) {print (colored ($_, $color_done))}
					else {print (colored ($_, $color_else))}
				}
				$counter++;
			}
		} else {		
			if (/\Q$_[0]/) {							#RegExp filters ls by given commandline argument.
				switch (substr ($_,3,3)) {
					case (/^\([aA]\)/) {print (colored ($_, $color_a))}
					case (/^\([bB]\)/) {print (colored ($_, $color_b))}
					case (/^\([cC]\)/) {print (colored ($_, $color_c))}
					case (/^x\s\d/) {print (colored ($_, $color_done))}
					else {print (colored ($_, $color_else))}
				}
			$counter++;
			}
		}
	}
	print ("---\n");
	print ($counter . " of " . ($#keys + 1) . " tasks in " . $file_path . "todo.txt\n\n");	#Number of tasks
	close (READ_FILE);
}

sub pre {											#Append something to a specific line.
	@array = &get_content;
	open (WRITE_FILE, ">" . $file_path . "todo.txt");
	foreach $_(@array) {
		if ($line != $_[0]) {						#This checks if current line is the line to be manipulated. Used a lot.
			print (WRITE_FILE "$_\n");
		} else {
			print ("\nEdited task : $_\n");
			print (WRITE_FILE "$_[1]" . "$_\n");
		}
		$line++;
	}
	close (WRITE_FILE);
}

sub pri {											#Add/set pririty flag per line.
	@array = &get_content;
	open (WRITE_FILE, ">" . $file_path . "todo.txt");
	foreach $_(@array) {
		if ($line != $_[0]) {
			print (WRITE_FILE "$_\n");
		} else {
			print ("\nEdited : $_\n");
			if (/^\([a-zA-Z]\)/) {						#RegExp checks if pririty flag is set or not.
				substr ($_, 0, 3, "(\u$_[1])");		#If there is one, replace it.
			} else {
				$_ = "(\u$_[1]) " . $_;				#If not, set one.
			}
			print (WRITE_FILE "$_\n");
		}
		$line++;
	}
	close (WRITE_FILE);
}

sub rep {											#Replace line with new content.
	@array = &get_content;
	open (WRITE_FILE, ">" . $file_path . "todo.txt");
	foreach $_(@array) {
		if ($line != $_[0]) {
			print WRITE_FILE "$_\n";
		} else {
			print ("\nEdited : $_\n");
			print (WRITE_FILE "\L$_[1]\n");
		}
		$line++;
	}
	close (WRITE_FILE);
}
