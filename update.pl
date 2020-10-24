use strict;

# (C) rbianconi@enviroware.com
#https://github.com/robianc/parse_COVID-19

#License: http://dev.perl.org/licenses/artistic.html

# vers 20201024

use File::Slurp;
use JSON;
use Data::Dumper;
use Excel::Writer::XLSX;
use Excel::Writer::XLSX::Utility;

my $update = 1; # 1 to update with latest data 

#------------------------------------------------------- no serviceable parts below
my $json_file = 'dpc-covid19-ita-regioni.json';
if ($update) {
    unlink $json_file if (-e $json_file);
    system("wget","https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-regioni.json");
}
my $json = read_file($json_file);
my $data = from_json($json);
my %covid;

my @vars = (
        "ricoverati_con_sintomi",
        "terapia_intensiva",
        "totale_ospedalizzati",
        "isolamento_domiciliare",
        "totale_positivi",
        "variazione_totale_positivi",
        "nuovi_positivi",
        "dimessi_guariti",
        "deceduti",
        "casi_da_sospetto_diagnostico",
        "casi_da_screening",
        "totale_casi",
        "tamponi",
        "casi_testati",
        "note");
my @records = @{$data};
foreach my $record (@records) {
    my ($date,$time) = split ("T",$record->{'data'});
    map { $covid{$record->{'denominazione_regione'}}{$date}{$_} = $record->{$_} } @vars;
}

mkdir './data' unless (-e './data');
my $workbook = Excel::Writer::XLSX->new( './dpc-covid19-ita-regioni.xlsx' );    # Step 1
my $format = $workbook->add_format();
$format->set_num_format( '0.00' );
my $dformat = $workbook->add_format( num_format => 'dd/mm/yyyy' );

my @regioni = sort keys %covid;
foreach my $regione (@regioni) {
    my $worksheet = $workbook->add_worksheet($regione);
    my $outfile = "./data/$regione.csv";
    open(OUT,">$outfile") or die $!;
    print OUT join(",",('Date',@vars));
    my @dates = reverse sort keys %{$covid{$regione}};
    my $irow = 0;
    $worksheet->write_row($irow,0,["Data",@vars]);
    foreach my $date (@dates) {
        $irow++;
        my ($ye,$mo,$da) = split("-",$date);
        my @out = ("$da/$mo/$ye");
        foreach my $var (@vars) {
            push @out, $covid{$regione}{$date}{$var};
        }
        $worksheet->write_row($irow,0,[@out]);
    }
    close(OUT);

}
$workbook->close();
