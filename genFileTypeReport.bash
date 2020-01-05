#!/bin/bash
#
# genFileTypeReport.bash
#

readonly ScriptDir=$(readlink -f $(dirname ${BASH_SOURCE[0]}))
source $ScriptDir/GeneralSupportRoutines.bashenv

#
# Constants
#

readonly HTML_BGColor=wheat
readonly HTML_FontSize=9pt

readonly ReportTopNodes="bin boot cdrom dev etc home lib lib32 lib64 lost+found media mnt opt proc root run sbin snap srv sys tmp usr var"
readonly ReportColumnTitles="Directory-Node Block Character Directory Named-Pipe Regular-File Symbolic-Link Socket ALL"
readonly ReportFileTypeColors="greenyellow lightgray lightblue turquoise tan lightgoldenrod lightgreen"
readonly ReportFileTypes="b c d p f l s"

#
# Low-Level Procedures
#

getFTBGCByFileType() {
	declare -r _fileType=$1

	local fti=1
	for ft in $ReportFileTypes
	do
		if [[ $ft = $_fileType ]]
		then
			break
		fi
		(( fti = fti + 1 ))
	done
	set $ReportFileTypeColors
	echo -n ${!fti}
}

getFTCByColumn() {
	declare -r _cNo=$1

	set $ReportFileTypes
	echo -n ${!_cNo}
}

HTMLReportType() {
	[[ $1 = HTML ]]
}

TextReportType() {
	[[ $1 = TEXT ]]
}

#2345678901234567890123456789012345678901234567890123456789012345678901234567890
writeWithPaddedSpace() {
	declare -r _dataA="$1"
	declare -r _fmtLength="$2"
	declare -r _reversedFmt="$3"

	declare -r Length=${#_dataA}
	local pl

	if (( _fmtLength < Length ))
	then
		m="Data length of $Length ($_dataA) too long for format ($_fmtLength)."	
		xFatal "$m"
	fi
	if [[ -n $_reversedFmt ]]
	then
		echo -n "$_dataA"
	fi
	(( pl = _fmtLength - Length ))
	for i in $(seq 1 $pl)
	do
		echo -n " "
	done
	if [[ -z $_reversedFmt ]]
	then
		echo -n "$_dataA"
	fi
}

#
# Mid-Level Procedures
#

genColumnHeader() {
	declare -r _reportType=$1

	local b
	local ftc
	local ci=0
	for chdr in $ReportColumnTitles
	do
		if (( ci > 0 ))
		then
			ftc=$(getFTCByColumn $ci)
			b="$chdr ($ftc)"
		else
			b=$chdr
		fi
		if TextReportType $_reportType
		then
			if (( ci == 0 ))
			then
				writeWithPaddedSpace "$b" 14 true
			else
				writeWithPaddedSpace "$b" 18
			fi
		else
			if (( ci == 0 ))
			then
				b="<th>$b</th>"
			else
				b="<td>$b</td>"
			fi
			echo -n $b
		fi
		(( ci = ci + 1 ))
	done
}

#
# High-Level Procedures
#

printUsage() {
	cat <<EOU
$0 -m|--html|--markup
$0 -h|-?|--help 
EOU
}

writeFileTypeCountColumn() {
	declare -r _reportType=$1
	declare -r _fileType=$2
	declare -r _fileTypeCount=$3

	local bgc
	if TextReportType $_reportType
	then
		writeWithPaddedSpace $_fileTypeCount 18
	else
		if [[ -n $_fileType ]]
		then
			bgc=$(getFTBGCByFileType $_fileType)
			echo -n "<td align=right style='background-color: $bgc;'>$_fileTypeCount</td>"
		else
			echo -n "<td align=right style='background-color: skyblue;'>$_fileTypeCount</td>"
		fi
	fi
}

writeNodeColumn() {
	declare -r _reportType=$1
	declare -r _topNode="$2"

	if TextReportType $_reportType
	then
		writeWithPaddedSpace "/$_topNode" 14 true
	else
		echo -n "<tr><th align=left>&sol;$_topNode</th>"
	fi
	echo -n $fmtdnode
}

writeRowEnd() {
	declare -r _reportType=$1

	if TextReportType $_reportType
	then
		echo
		return
	fi
	cat <<EOROW
</tr>
EOROW
}

writeTableEnd() {
	declare -r _reportType=$1

	if TextReportType $_reportType
	then
		return
	fi
	cat <<EOTABLE
</table>
EOTABLE
}

writeTableTop() {
	declare -r _reportType=$1

	declare -r ColumnHeader=$(genColumnHeader $_reportType)

	if TextReportType $_reportType
	then
		echo "Directory Node Counts By File Type"
		echo "$ColumnHeader"
	else
		cat <<EOTABLETOP
<h2>Directory Node Counts By File Type</h2>
<table border=1 style='background-color: $HTML_BGColor; fontsize: $HTML_FontSize;'>
$ColumnHeader
EOTABLETOP
	fi
}

#
# Command Line Argument Parsing
#

if (( $# == 0 ))
then
	readonly ReportType=TEXT
elif [[ $1 = --HTML || $1 = --html || $1 = -m || $1 = --markup || $1 = -M || $1 = --MARKUP ]]
then
	readonly ReportType=HTML
elif [[ $1 = '-h' ||  $1 = '-?' ||  $1 = '--help' ]]
then
	printUsage
	exit 0
else
	printUsage
	exit 1
fi

#
# Main Procedure
#

writeTableTop $ReportType

for topnode in $ReportTopNodes ""
do
	writeNodeColumn $ReportType $topnode
	for filetype in $ReportFileTypes ""
	do
		if [[ -n $filetype ]]
		then 
			ftc=$(find /$topnode -type $filetype 2>/dev/null | wc -l)
		else
			ftc=$(find /$topnode 2>/dev/null | wc -l)
		fi
		writeFileTypeCountColumn $ReportType "$filetype" $ftc
	done
	writeRowEnd $ReportType
done
writeTableEnd $ReportType

# End of genFileTypeReport.bash
