---
  title: "Getting Started"
---

This page provides a quick introduction to installing scaffolder and creating
a simple scaffold from three fasta sequences. Scaffolder has been tested on
Debian and OS X. There may differences when trying this tutorial on Windows. If
you have any questions or comments feel free to ask on the [scaffolder mailing
list][email].

### Installation

Scaffolder requires both [Ruby][] and [RubyGems][] to install. These are
usually already installed or can be installed easy on Mac OS X and Linux
distributions. The software can be tested by running the following commands on
the console or terminal:

<%= highlight %>

  ruby -v
  gem -v

<%= endhighlight %>

If both of these return without error, scaffolder can be installed via RubyGems
using the following command.

<%= highlight %>

  gem install scaffolder scaffolder-tools

<%= endhighlight %>

Test scaffolder is has been correctly installed by running this command. This
should print the list of available scaffolder commands.

<%= highlight %>

  scaffolder

<%= endhighlight %>

If this fails or returns an error the RubyGems executable directory may not be
in the shell path. The location of this can found using the following command,
which should be added to the PATH variable in the respective shell login
script. Examples of updating the shell path are avaiable [for OS X][osx_path]
and [for Linux][linux_path]

<%= highlight %>

  # Add the output of this your $PATH
  gem env | grep EXECUTABLE DIRECTORY | cut -d : -f 2

<%= endhighlight %>

### Creating a simple scaffold

Create a text file named 'sequences.fna' containing the following nucleotides
sequences. The following steps will progress through using the sequences to
create a simple scaffold.

<%= highlight %>

  >sequence1
  AAAAAAAAAAAA
  >sequence2
  TTTTTTTTTTTT
  >sequence3
  GGGGG

<%= endhighlight %>

Create the file 'scaffold.yml' and add the content below. This is will the
scaffold file for specifying how the sequences should be joined together.

<%= highlight %>

---
- sequence:
    source: 'sequence1'

<%= endhighlight %>

This specifies a scaffold containing a single sequence entry. YAML formatted
documents should begin with triple dashes ('---'). Each entry in the scaffold
list also starts with a dash ('-'). The 'sequence' tag specifies the first
entry in the scaffold is a sequence. The 'source' tag identifies the name of
the sequence to use. The source tag should match the first space delitimited
word in the corresponding sequence fasta header.

The sequence for this scaffold is produced by running the scaffolder sequence
command with the locations of these two files.

<%= highlight %>

  scaffolder sequence scaffold.yml sequences.fna

<%= endhighlight %>

This produces the nucleotide sequence of sequence1 in the fasta file. This is
as expected as the scaffold is rather simple and only specifies one sequence
entry.

<%= highlight %>

  > 
  AAAAAAAAAAAA

<%= endhighlight %>

Update the scaffold file so that it now resembles the snippet below. Here the
second sequence from the fasta file is added to the scaffold. Additionally an
unknown region is added between these sequences.

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

Next imagine there is a region in sequence1 which we wish to replace. For
example if you had performed PCR to determine the correct sequence in this
area. Update the scaffold file so to resemble the code below.

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
that this is the case.

<%= highlight %>

  >.
  AAGGGGGAAAAAAANNNNNTTTTTTTTTTTT

<%= endhighlight %>

This concludes the tutorial for creating a simple scaffold. More complex
scaffolds can be created by adding further sequences and inserts to the
scaffold. More details about the scaffolder format can be found at
[the scaffolder API][api]. Details on the avaiable scaffolder commands can
be found on [the man pages][man].

[Ruby]: http://www.ruby-lang.org/
[RubyGems]: http://rubygems.org/
[osx_path]: http://stackoverflow.com/questions/135688/setting-environment-variables-in-os-x
[linux_path]: http://www.troubleshooters.com/linux/prepostpath.htm
[man]: /man
[api]: http://rubydoc.info/gems/scaffolder/0.4.1/Scaffolder
