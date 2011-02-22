---
  title: "Getting Started"
---

This page outlines how to install scaffolder and then how to create a simple
scaffold of three sequences. Scaffolder has been tested on Debian and OS X.
There may differences when trying this tutorial on Windows. If you have any
questions or comments feel free to ask on the [scaffolder mailing list][email].

### Installation

Scaffolder requires both [Ruby][] and [RubyGems][] to install and run. These
are usually already installed or can be installed easy on Mac OS X and Linux
distributions. The presence of this software can be tested by running the
following commands:

<%= highlight %>

  ruby -v
  gem -v

<%= endhighlight %>

If both of these return without error, scaffolder can be installed via RubyGems
using the following command.

<%= highlight %>

  gem install scaffolder scaffolder-tools

<%= endhighlight %>

Test scaffolder is installed by running this command at the terminal. This
should print the list of available scaffolder commands.

<%= highlight %>

  scaffolder

<%= endhighlight %>

If this fails or returns an error the RubyGems executable directory may not be
in the shell path. The location of this can found using the following command.
This should be added to the PATH variable in the respective shell login script.
Examples of this [for OS X][osx_path] and [for Linux][linux_path]

<%= highlight %>

  gem env | grep EXECUTABLE DIRECTORY | cut -d : -f 2

<%= endhighlight %>

[Ruby]: http://www.ruby-lang.org/
[RubyGems]: http://rubygems.org/
[osx_path]: http://stackoverflow.com/questions/135688/setting-environment-variables-in-os-x
[linux_path]: http://www.troubleshooters.com/linux/prepostpath.htm

### Creating a simple scaffold

Consider that the following nucleotides sequences in a fasta file named
'sequences.fna'. The following steps will progress through using these to
create a genome scaffold.

<%= highlight %>

  >sequence1
  AAAAAAAAAAAA
  >sequence2
  TTTTTTTTTTTT
  >sequence3
  GGGGG

<%= endhighlight %>

First create the file 'scaffold.yml' with the following content. This specifies
a scaffold containing a single entry. YAML formatted documents should begin
with the triple dashes ('---'). Each entry in the scaffold also starts with
a dash ('-'). The 'sequence' tags specifies this is a sequence which should be
added from the fasta file. The 'source' tag identifies the name sequence which
you can see matches the fasta header for the sequence in the fasta file.

<%= highlight %>

---
- sequence:
    source: 'sequence1'

<%= endhighlight %>

The sequence for this scaffold is produced by running the following command
pointing to the two files.

<%= highlight %>

  scaffolder sequence scaffold.yml sequences.fna

<%= endhighlight %>

<%= highlight %>

  > 
  AAAAAAAAAAAA

<%= endhighlight %>

As expected this just produces the sequence from sequence1 in the fasta file.
Update the scaffold file so that it now resembles the snippet below. Here the
second sequence from the fasta file is added to the scaffold. Additionally an
unknown region is added between the two sequences.

<%= highlight %>

  ---
  - sequence:
      source: 'sequence1'
  - unresolved:
      length: 5
  - sequence:
      source: 'sequence2'

<%= endhighlight %>

Running the scaffolder command again will generate the scaffold sequence. This
will contain the two sequences joined by a 5bp region of 'N' characters.

<%= highlight %>

  >.
  AAAAAAAAAAAANNNNNTTTTTTTTTTTT

<%= endhighlight %>

Next imagine there is a region of sequence in sequence1 which we wish to
replace. Update the scaffold file sow that it now looks like this

<%= highlight %>

  ---
  - sequence:
      source: 'sequence1'
      inserts:
      - source: 'sequence3'
        open: 3
        close: 5
  - unresolved:
      length: 5
  - sequence:
      source: 'sequence2'

<%= endhighlight %>

Here we have added an insert sequence to sequence1. This replaces the region in
the range 3...5 (specified by the open and close coordinates) with sequence3.
Running the scaffolder command again we can see that this is the case.

<%= highlight %>

  >.
  AAGGGGGAAAAAAANNNNNTTTTTTTTTTTT

<%= endhighlight %>
