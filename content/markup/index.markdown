--- 
  title: Opinionated genome scaffolding
---

Edit your genome sequence using a simple human readable syntax. Manage contig positions and add inserts all in a plain text file.

<%= highlight %>
---
  -
    sequence:
      source: "contig00001"
      reverse: true
  -
    unresolved:
      length: 10
  -
    sequence:
      source: "scaffold00006"
      inserts:
      -
        source: "pcr_sequence_6-1"
        open: 599152
        close: 599817
<%= endhighlight %>
