---
  title: "Getting Started"
---

This page provides a quick introduction to installing scaffolder and creating
a simple scaffold from three nucleotide sequences. Scaffolder has been tested
on Debian and OS X but there may differences on Windows. If you have any
questions or comments feel free to ask on the [scaffolder mailing list][email].

### Installation

Scaffolder requires both [Ruby][] and [RubyGems][] to run. These are usually
already installed or can be installed easy on Mac OS X and Linux distributions.
The software can be tested by running the following commands on the console or
terminal (excluding the '$' sign):

<%= highlight %>

  $ ruby -v
  $ gem -v

<%= endhighlight %>

If both of these return without error, scaffolder can be installed via RubyGems
using the following command:

<%= highlight %>

  $ gem install scaffolder scaffolder-tools

<%= endhighlight %>

The install can be tests by running the following command. This should print
the list of available scaffolder options.

<%= highlight %>

  $ scaffolder

<%= endhighlight %>

If this fails or returns an error the RubyGems executable directory may not be
in your shell path. The location of this can found using the following command,
the result of which should be added to the $PATH variable in your shell login
script. Examples of updating the shell path are available [for OS X][osx_path]
and [for Linux][linux_path]

<%= highlight %>

  # Add the output of this your $PATH
  $ gem env | grep "EXECUTABLE DIRECTORY" | cut -d : -f 2

<%= endhighlight %>

### Creating a simple scaffold

To begin creating a scaffold, create a text file named 'sequences.fna'
containing the following nucleotide sequences. These will be our example
sequences which we wish to build a scaffold with. The following steps will
progress through creating a simple scaffold.

<%= highlight %>

  >sequence1
  AAAAAAAAAAAA
  >sequence2
  TTTTTTTTTTTT
  >sequence3
  GGGGG

<%= endhighlight %>

Create the file 'scaffold.yml' and add the content below. This is the scaffold
file specifying how our nucleotide sequences should be joined together.

<%= highlight %>

  ---
  - sequence:
      source: 'sequence1'

<%= endhighlight %>

The scaffold is written in the [YAML][] format. YAML is data serialisation
format which is useful to pass information between computer software but which
also can be easily edited by hand. YAML formatted documents should begin with
three dashes ('---'). The scaffold file is represented as a list of sequence
entries. Using the YAML format each entry is defined by starting with a dash
('-') then indented by two spaces for the remaining lines of the entry.

As you can see in the code above this scaffold file has only one entry. The
'sequence' tag specifies that this entry is a sequence. The 'source' tag
identifies the name of the sequence to use. The source tag should match the
first space delimited word in the corresponding sequence fasta header.

The sequence for this simple scaffold is produced by running the scaffolder
sequence command giving the locations of the two files we have just created.

<%= highlight %>

  $ scaffolder sequence scaffold.yml sequences.fna

<%= endhighlight %>

This returns the nucleotide sequence of sequence1. This is as expected as the
scaffold only contains one sequence entry.

<%= highlight %>

  >.
  AAAAAAAAAAAA

<%= endhighlight %>

### Adding additional sequences to the scaffold

A scaffold with only a single sequence is rather simple. Update the scaffold
file so that it now resembles the text below. Here we have added a second
sequence from the fasta file and an unknown region between these two sequences.

<%= highlight %>

  ---
  - sequence:
      source: 'sequence1'
  - unresolved:
      length: 5
  - sequence:
      source: 'sequence2'

<%= endhighlight %>

Running the scaffolder command again will generate following super sequence.
This contains the two sequences joined by the 5bp region of 'N' characters we
specified. These unresolved regions can be used for joining contigs by
approximate distances.

<%= highlight %>

  >.
  AAAAAAAAAAAANNNNNTTTTTTTTTTTT

<%= endhighlight %>

### Replacing regions of sequence in the scaffold

Imagine there is a region in sequence1 which we wish to replace. For example
the start of region on is poor quality or it is an already scaffolded set of
contigs containing gaps. Performing PCR would determine the correct sequence in
this area but we need a way to update sequence1 in the scaffold. We can do this
by updating the scaffold file as follows:

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

Here we have added an insert to sequence1 using the "inserts" tag. This
replaces the region in the range 3...5 (specified by the open and close
coordinates) with sequence3. Running the scaffolder command again we can see
that this is now the case where four guanine bases have been inserted

<%= highlight %>

  >.
  AAGGGGGAAAAAAANNNNNTTTTTTTTTTTT

<%= endhighlight %>

This is a brief tutorial for creating a simple scaffold. More complex scaffolds
can be created by adding further sequences and inserts to the scaffold. More
details about the scaffolder format can be found at [the scaffolder API][api]
and the [scaffolder-format man page][format]. Details on the available
scaffolder commands can be found on [the man pages][man].

[Ruby]: http://www.ruby-lang.org/
[RubyGems]: http://rubygems.org/
[osx_path]: http://stackoverflow.com/questions/135688/setting-environment-variables-in-os-x
[linux_path]: http://www.troubleshooters.com/linux/prepostpath.htm
[man]: /man
[api]: http://rubydoc.info/gems/scaffolder/0.4.1/Scaffolder
[email]: http://groups.google.com/group/scaffolder
[yaml]: http://www.yaml.org/
[format]: /man/scaffolder-format/
