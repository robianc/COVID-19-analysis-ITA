# COVID-19_reloaded

(C) Roberto Bianconi 2020 

A tool for the analysis of Italian COVID-19 data at regional level.

<b>Open the file COVID-19-analisi.xlsx and insert the region of interest, the variables to analyze and plot, the rolling average period.</b>

The data are updated daily at https://github.com/pcm-dpc/COVID-19

You can run the Perl code provided here (update.pl) to update the data for COVID-19-analisi.xlsx.

License: http://dev.perl.org/licenses/artistic.html

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

## Installation of update.pl:

You may need to install these Perl modules with cpan or cpanm. 

On Ubuntu, for example:
```
$ sudo apt-get cpanminus
$ sudo cpanm JSON
$ sudo cpanm File::Slurp
$ sudo cpanm Excel::Writer::XLSX
```
On Windows you can install www.strawberryperl.com and then:
```
> cpanm JSON
> cpanm File::Slurp
> cpanm Excel::Writer::XLSX
```

Usage:
```
$ perl update.pl
```

Note:
Set within code `$update = 0` to disable JSON file download.
