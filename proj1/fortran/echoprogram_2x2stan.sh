# !/bin/bash
# this program echos ./simbin/dmd/polsqu2x2anneal2well.f90

## ARGUMENTS
# first argument: simulation id
SIMID=$1
# second argument: simulation density as an area fraction
ETA=$2
# third argument: simulation chirality fraction
XA=$3

## PARAMETERS
# formated area fraction
ETASTRING=$(printf '%3.2f' $(awk "BEGIN { eta=${ETA}/100; print eta }"))
# formatted chirality fraction
XASTRING=$(printf '%3.2f' $(awk "BEGIN { xa=${XA}/10; print xa }"))

echo !'*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo !'*''*'' 'Programmer:' 'Matthew' 'A' 'Dorsey' '
echo !'*''*'' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'Dr.' 'Carol' 'Hall' 'Research' 'Laboratory
echo !'*''*'' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'Chemical' 'and' 'Biomolecular' 'Engineering' '
echo !'*''*'' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'North' 'Carolina' 'State' 'University' '
echo !'*''*'
echo !'*''*'' '
echo !'*''*'' 'Date:' '05/11/2021
echo !'*''*'' '
echo !'*''*'' '' '' '' 'Purpose:' 'simulate' 'a' 'rigid,' 'polarized' 'square' 'using' 'four' '
echo !'*''*'' '' '' '' '' '' '' '' '' '' '' '' '' 'spheres.' 'all' 'spheres' 'are' 'bonded' 'to' 'one' 'another,' '
echo !'*''*'' '' '' '' '' '' '' '' '' '' '' '' '' 'in' 'order' 'to' 'maintain' 'their' 'formation.' 'one' 'side' '
echo !'*''*'' '' '' '' '' '' '' '' '' '' '' '' '' 'of' 'the' 'sphere' 'is' 'polarized,' 'while' 'the' 'other' '
echo !'*''*'' '' '' '' '' '' '' '' '' '' '' '' '' 'maintains' 'a' 'neutral' '\"charge\".' 'spheres' 'which' 'share' '
echo !'*''*'' '' '' '' '' '' '' '' '' '' 'opposite' 'charges' 'interact' 'via' 'an' 'attractive,' 'square' '
echo !'*''*'' '' '' '' '' '' '' '' '' '' '' '' '' 'well' 'potential.' 'spheres' 'which' 'share' 'different' '
echo !'*''*'' '' '' '' '' '' '' '' '' '' '' '' '' 'charges' 'attract' 'via' 'a' 'repuslive,' 'square' 'shoulder' '
echo !'*''*'' '' '' '' '' '' '' '' '' '' '' '' '' 'potential.' 'the' 'potential' 'between' 'two' 'charged' '
echo !'*''*'' '' '' '' '' '' '' '' '' '' '' '' '' 'spheres' 'consists' 'of' 'three' 'discontinuities' 'defined
echo !'*''*'' '' '' '' '' '' '' '' '' '' '' '' '' 'by' 'a' 'well' 'depth' 'epsilon,' 'where' 'by' 'the' 'well' 'depths
echo !'*''*'' '' '' '' '' '' '' '' '' '' '' '' '' 'increase' 'progressively' 'as' 'the' 'pair' 'get' 'closer' 'to
echo !'*''*'' '' '' '' '' '' '' '' '' '' '' '' '' 'the' 'hard' 'sphere' 'diameter.
echo !'*''*'
echo !'*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo module' 'polarizedsquaremodule
echo implicit' 'none' '
echo save' '
echo 
echo !' 'TO' 'DO:' 'create' 'looping' 'function' 'which' 'loops' 'through' 'an' 'type"("id")"' 'variable
echo 
echo 
echo 
echo !'*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo !'*''*'' 'GLOBAL' 'CONSTANTS
echo !'*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo !' ''*''*'' 'constants' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo integer,' 'parameter' '::' 'dbl' '=' 'selected_real_kind' '"("32")"' '!' 'integer' 'which' 'determines' 'precision' 'of' 'real' 'numbers
echo real"("kind=dbl")",' 'parameter' '::' 'pi' '=' '3.141592653589793238
echo real"("kind=dbl")",' 'parameter' '::' 'twopi' '=' '2.' ''*'' 'pi
echo real"("kind=dbl")",' 'parameter' '::' 'halfpi' '=' 'pi' '/' '2.
echo real"("kind=dbl")",' 'parameter' '::' 'bigtime' '=' '1e10' '!' 'unreasonably' 'large' 'time
echo !' ''*''*'' 'colors' '"("rbg' 'format")"' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo character"("len=12")",' 'parameter' '::' 'red' '=' '\'' '1' '0.15' '0.15\'
echo character"("len=12")",' 'parameter' '::' 'blue' '=' '\'' '0.1' '1' '0.3\'
echo character"("len=12")",' 'parameter' '::' 'green' '=' '\'' '0' '0' '1\'
echo character"("len=12")",' 'parameter' '::' 'orange' '=' '\'' '1' '0' '0.64\'
echo character"("len=12")",' 'parameter' '::' 'purple' '=' '\'' '1' '1' '0\'
echo character"("len=15")",' 'parameter' '::' 'white' '=' '\'' '0.75' '0.75' '0.75\'
echo 
echo 
echo !' ''*''*'' 'ensemble' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo integer,' 'parameter' '::' 'ndim' '=' '2' '!' 'number' 'of' 'dimensions' '
echo integer,' 'parameter' '::' 'cell' '=' '32' '!' 'number' 'of' 'lattice' 'cells
echo integer,' 'parameter' '::' 'mer' '=' '4' '!' 'number' 'of' 'hardspheres' 'which' 'make' 'one' 'cube
echo real"("kind=dbl")",' 'parameter' '::' 'xa' '=' '$XASTRING' '!' 'mol' 'fraction' 'of' 'A' 'chirality' '[NOTE:' 'value' 'must' 'be' 'between' '0' 'and' '1]
echo real"("kind=dbl")",' 'parameter' '::' 'eta' '=' '$ETASTRING' '!' 'packing' 'fraction:' 'ration' 'of' 'total' 'sphere' 'area' 'to' 'total' 'area' '[RW' 'MAX:' '~' '0.4..]
echo real"("kind=dbl")",' 'parameter' '::' 'tempstart' '=' '1.5' '!' 'starting' 'temperature' 'of' 'the' 'simulation' '
echo real"("kind=dbl")",' 'parameter' '::' 'tempfinal' '=' '0.01' '!' 'final' 'system' 'temperature' 'set' 'point' '
echo real"("kind=dbl")",' 'parameter' '::' 'sigma1' '=' '1.0' '!' 'distance' 'from' 'sphere' 'center' 'to' 'first' 'discontinuity' '"("diameter' 'of' 'hardsphere")"
echo real"("kind=dbl")",' 'parameter' '::' 'sigma2' '=' '1.15' ''*'' 'sigma1' '!' 'distance' 'from' 'sphere' 'center' 'to' 'second' 'discontinuity
echo real"("kind=dbl")",' 'parameter' '::' 'sigma3' '=' '1.4' ''*'' 'sigma1' '!' 'distance' 'from' 'sphere' 'center' 'to' 'third' 'discontinuity
echo real"("kind=dbl")",' 'parameter' '::' 'epsilon1' '=' '1.0000' '!' 'reduced' 'energy' 'parameter
echo real"("kind=dbl")",' 'parameter' '::' 'epsilon2' '=' '0.8259' ''*'' 'epsilon1' '!' 'depth' 'of' 'innermost' 'well
echo real"("kind=dbl")",' 'parameter' '::' 'epsilon3' '=' '0.3146' ''*'' 'epsilon1' '!' 'depth' 'of' 'outermost' 'well
echo real"("kind=dbl")",' 'parameter' '::' 'delta' '=' '0.015' '!' 'half' 'the' 'bond' 'length
echo real"("kind=dbl")",' 'parameter' '::' 'exittemp' '=' '0.01' '!' 'final' 'system' 'temperature' '
echo !'*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo integer,' 'parameter' '::' 'cube' '=' 'cell' ''*''*'' '2' '!' 'number' 'of' 'cubes
echo integer,' 'parameter' '::' 'mols' '=' 'cube'*'mer' '!' 'number' 'of' 'hardspheres
echo integer,' 'parameter' '::' 'na' '=' 'cube' ''*'' 'xa' '!' 'number' 'of' 'a' 'chirality' 'cubes' '
echo real"("kind=dbl")",' 'parameter' '::' 'excluded_area' '=' '1.' '+' '"(""("3.' '/' '4.")"' ''*'' 'pi")"' '!' 'area' 'occupied' 'by' 'one' '2x2' 'square
echo real"("kind=dbl")",' 'parameter' '::' 'area' '=' '"("excluded_area' ''*'' 'cube")"' '/' 'eta' '!' 'area' 'of' 'simulation' 'box
echo real"("kind=dbl")",' 'parameter' '::' 'region' '=' 'sqrt' '"("area")"' '!' 'length' 'of' 'simulation' 'box' 'wall
echo real"("kind=dbl")",' 'parameter' '::' 'density' '=' 'real"("cube")"' '/' 'area' '!' 'number' 'density' 'of' 'cubes
echo real"("kind=dbl")",' 'parameter' '::' 'sg1sq' '=' 'sigma1' ''*''*'' '2
echo real"("kind=dbl")",' 'parameter' '::' 'sg2sq' '=' 'sigma2' ''*''*'' '2
echo real"("kind=dbl")",' 'parameter' '::' 'sg3sq' '=' 'sigma3' ''*''*'' '2
echo real"("kind=dbl")",' 'parameter' '::' 'inbond' '=' 'sigma1' '-' 'delta' '!' 'inner' 'bond' 'distance
echo real"("kind=dbl")",' 'parameter' '::' 'onbond' '=' 'sigma1' '+' 'delta' '!' 'outer' 'bond' 'distance
echo real"("kind=dbl")",' 'parameter' '::' 'icbond' '=' 'sqrt"("2' ''*'' 'sigma1")"' '-' 'delta' '!' 'inner' 'cross' 'bond' 'distance
echo real"("kind=dbl")",' 'parameter' '::' 'ocbond' '=' 'sqrt"("2' ''*'' 'sigma1")"' '+' 'delta' '!' 'outer' 'cross' 'bond' 'distance
echo !' ''*''*'' 'anderson' 'thermostat' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo logical,' 'parameter' '::' 'thermostat' '=' '.true.' '!' 'anderson' 'thermostat' 'status:' '.false.' '==' 'off,' '.true.' '==' 'on
echo real"("kind=dbl")",' 'parameter' '::' 'thermal_conductivity' '=' '200.0' '!' 'the' 'thermal' 'conductivity' 'of' 'the' 'hardsphere' 'system' '[THIS' 'VALUE' 'HAS' 'NOT' 'BEEN' 'VERIFIED!!]
echo 
echo 
echo !' ''*''*'' 'settings' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo integer,' 'parameter' '::' 'event_equilibrium' '=' '50000000' '!' 'number' 'of' 'steps' 'during' 'which' 'the' 'system' 'is' 'considered' 'at' 'equilibrium,' 'equilibrium' 'property' 'values' 'are' 'taken
echo integer,' 'parameter' '::' 'event_equilibriate' '=' '150000000' '!' 'number' 'of' 'steps' 'during' 'which' 'the' 'system' 'is' 'allowed' 'to' 'equilibriate
echo integer,' 'parameter' '::' 'event_reschedule' '=' '10000' '!' 'number' 'of' 'steps' 'by' 'which' 'to' 'reschedule' 'entire' 'event' 'calander,' 'adjust' 'temperatures
echo integer,' 'parameter' '::' 'event_average' '=' '10000000' '!' 'number' 'of' 'steps' 'between' 'property' 'calculations' 'and' 'complete' 'rescheduling
echo integer,' 'parameter' '::' 'propfreq' '=' '1000000' '!' 'frequency' 'of' 'property' 'calculations,' 'when' 'the' 'system' 'is' 'not' 'at' 'equilibrium
echo real"("kind=dbl")",' 'parameter' '::' 'tol' '=' '0.001' '!' 'amount' 'by' 'which' 'to' 'allow' 'mistakes' 'from' 'numberical' 'integration' '"("i.e.' 'overlap' 'and' 'bcs")"
echo integer,' 'parameter' '::' 'debug' '=' '0' '!' 'debugging' 'status:' '0' '==' 'off,' '1' '==' 'on,' '2' '==' 'extra' 'on' '
echo 
echo 
echo !' ''*''*'' 'order' 'parameters' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo integer,' 'parameter' '::' 'orderlength' '=' '15
echo real"("kind=dbl")",' 'parameter' '::' 'orderwidth' '=' 'sigma3
echo 
echo 
echo !' ''*''*'' 'file' 'management' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo character"("len=15")",' 'parameter' '::' 'simtitle' '=' '\'polsquare\'
echo character"("len=10")",' 'parameter' '::' 'simid' '=' '\'${SIMID}_\'
echo character"("len=40")",' 'parameter' '::' 'fpossavefile' '=' 'trim"("simtitle")"' '//' 'trim"("simid")"' '//' '\'_fposSAVE.dat\'' '!' 'save' 'file' 'containing' 'all' 'false' 'position' 'vectors' '
echo character"("len=40")",' 'parameter' '::' 'velsavefile' '=' 'trim"("simtitle")"' '//' 'trim"("simid")"' '//' '\'_velSAVE.dat\'' '!' 'save' 'file' 'containing' 'all' 'velocity' 'vectors' '
echo character"("len=40")",' 'parameter' '::' 'chaisavefile' '=' 'trim"("simtitle")"' '//' 'trim"("simid")"' '//' '\'_chaiSAVE.dat\'' '!' 'save' 'file' 'containing' 'chiraliry' 'description' 'of' 'each' 'grouping
echo character"("len=40")",' 'parameter' '::' 'simsavefile' '=' 'trim"("simtitle")"' '//' 'trim"("simid")"' '//' '\'_simSAVE.dat\'' '!' 'save' 'file' 'containing' 'all' 'simulation' 'state' '
echo character"("len=40")",' 'parameter' '::' 'annealsavefile' '=' 'trim"("simtitle")"' '//' 'trim"("simid")"' '//' '\'_annSAVE.dat\'' '!' 'save' 'file' 'containing' 'the' 'status' 'of' 'the' 'annealing' 'simulation
echo integer,' 'parameter' '::' 'saveiounit' '=' '11' '
echo integer,' 'parameter' '::' 'simiounit' '=' '12
echo integer,' 'parameter' '::' 'coorsphiounit' '=' '13
echo integer,' 'parameter' '::' 'coorsquiounit' '=' '14
echo integer,' 'parameter' '::' 'reportiounit' '=' '15
echo integer,' 'parameter' '::' 'annealiounit' '=' '16
echo integer,' 'parameter' '::' 'opiounit' '=' '17
echo !' ''*''*'' 'animation' 'settings' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo integer,' 'parameter' '::' 'moviesph' '=' '1' '!' 'movie' 'making' 'status' 'of' 'simulation' 'as' 'spheres:' '0' '==' 'off,' '1' '==' 'on
echo integer,' 'parameter' '::' 'moviesqu' '=' '1' '!' 'movie' 'making' 'status' 'of' 'simulation' 'as' 'squares:' '0' '==' 'off,' '1' '==' 'on
echo real"("kind=dbl")",' 'parameter' '::' 'movfreq' '=' '100.0' '!' 'frequency' 'to' 'take' 'snapshots' 'of' 'movies' '[reduced' 'seconds]
echo 
echo 
echo !' ''*''*'' 'cell' '+' 'neighbor' 'list' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo integer,' 'parameter' '::' 'nbrListSize' '=' '8' '!' 'average' 'number' 'of' 'neighbors' 'per' 'particle' '
echo integer,' 'parameter' '::' 'nbrListSizeMax' '=' '100' '!' 'maximum' 'number' 'of' 'particles' 'accessible' 'to' 'list' '
echo real"("kind=dbl")",' 'parameter' '::' 'nbrRadiusMinInt' '=' '3.0' '!' 'integer' 'used' 'for' 'determing' 'the' 'max' 'displacement' 'required' 'for' 'a' 'neighborlist' 'update
echo real"("kind=dbl")",' 'parameter' '::' 'nbrRadiusMin' '=' '"("nbrRadiusMinInt' '/' '"("nbrRadiusMinInt' '-' '1")"")"' ''*'' '"("sigma3' '-' '"("sigma1' '/' 'nbrRadiusMinInt")"")"' '!' 'minimum' 'required' 'radius
echo real"("kind=dbl")",' 'parameter' '::' 'nbrRadius' '=' 'max"("sqrt"(""("real"("nbrListSize")"' '/' '"("real"("mer")"' ''*'' 'density")"")"' ''*'' '"("1.0' '/' 'pi")"")",' 'nbrRadiusMin")"' '!' 'radius' 'of' 'neighborlist
echo real"("kind=dbl")",' 'parameter' '::' 'nbrDispMax' '=' '"("nbrRadius' '-' 'sigma1")"' '/' 'nbrRadiusMinInt' '!' 'max' 'particle' 'displacement' 'before' 'a' 'neighborlist' 'update' 'is' 'required
echo integer,' 'parameter' '::' 'nCells' '=' 'floor' '"("region' '/' 'nbrRadius")"' '!' 'number' 'of' 'cells' 'in' 'one' 'dimension,' 'cell' 'length' 'cannot' 'be' 'shorter' 'than' 'the' 'nerighbor' 'radius
echo real"("kind=dbl")",' 'parameter' '::' 'lengthCell' '=' 'region' '/' 'real' '"("nCells")"' '!' 'legnth' 'of' 'each' 'cell' 'in' 'one' 'dimension,' 'must' 'be' 'greater' 'than' 'the' 'square' 'well' 'length' '"("sig2")"
echo 
echo 
echo 
echo !'*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo !'*''*'' 'GLOBAL' 'TYPES:' 'data' 'constructions' 'for' 'OOP
echo !'*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo type' '::' 'position' '
echo ' '' '' '' 'real"("kind=dbl")",' 'dimension"("ndim")"' '::' 'r' '!' 'vector' 'describing' 'the' 'position' 'of' 'one' 'sphere
echo end' 'type' 'position' '
echo 
echo type' '::' 'velocity
echo ' '' '' '' 'real"("kind=dbl")",' 'dimension"("ndim")"' '::' 'v' '!' 'vector' 'describing' 'the' 'velocity' 'of' 'one' 'sphere' '
echo end' 'type' '
echo 
echo type' '::' 'id
echo ' '' '' '' 'integer' '::' 'one,' 'two' '
echo end' 'type
echo 
echo type' '::' 'event' '
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'time' '
echo ' '' '' '' 'integer' '::' 'type
echo ' '' '' '' 'type"("id")"' '::' 'partner' '
echo end' 'type' 'event' '
echo 
echo type' '::' 'percolation_parameters' '!' '#percy
echo ' '' '' '' 'logical' '::' 'visited' '!' 'logical' 'value' 'that' 'determines' 'if' 'each' 'particle' 'has' 'already' 'been' 'considered' 'as' 'a
echo ' '' '' '' 'integer' '::' 'cluster' '!' 'the' 'cluster' 'that' 'the' 'particle' 'belongs' 'to' '"("null' 'if' 'it' 'has' 'not' 'yet' 'been' 'assigned' 'a' 'cluster")"
echo ' '' '' '' 'type"("id")"' '::' 'pnode' '!' 'node' 'that' 'is' 'connected' 'to' 'the' 'particle' 'via' 'an' 'edge
echo ' '' '' '' 'type"("position")"' '::' 'rvec' '!' 'vector' 'that' 'points' 'from' 'the' 'cluster' 'root' 'node' 'to' 'the' 'node' 'in' 'question
echo end' 'type' 'percolation_parameters
echo 
echo type' '::' 'particle
echo ' '' '' '' 'type"("position")"' '::' 'fpos' '!' 'false' 'location' 'of' 'sphere' '
echo ' '' '' '' 'type"("velocity")"' '::' 'vel' '!' 'velocity' 'of' 'sphere
echo ' '' '' '' 'integer' '::' 'pol' '!' 'polarization' 'of' 'sphere' '"("0' '=' 'neutral,' '-1' '=' 'negative,' '1' '=' 'positive")"
echo ' '' '' '' 'type"("event")"' '::' 'schedule' '!' 'next' 'event' 'for' 'sphere' '
echo ' '' '' '' 'type"("id")",' 'dimension"("nbrListSizeMax")"' '::' 'upnab,' 'dnnab' '!' 'uplist' 'and' 'downlist' 'neightbors' 'with' 'nbrRadius' 'distance' 'used' 'for' 'event' 'scheduling
echo ' '' '' '' 'type"("id")",' 'dimension"("orderlength")"' '::' 'orderlist' '!' 'list' 'of' 'oppositely' 'charged' 'pairs' 'within' 'orderwidth' 'distance' 'used' 'for' 'calculating' 'order' 'parameters' '
echo ' '' '' '' 'type"("percolation_parameters")"' '::' 'percy' '!' '#percy
echo end' 'type' 'particle
echo 
echo type' '::' 'group
echo ' '' '' '' 'type"("particle")",' 'dimension"("mer")"' '::' 'circle' '!' 'each' 'group' 'is' 'made' 'of' 'mer' 'circles' '
echo ' '' '' '' 'integer' '::' 'chai' '!' 'integer' 'describing' 'the' 'chiraliry' 'of' 'each' 'square' 'grouping' '
echo ' '' '' '' '!' 'TO' 'DO:' 'add' 'string' 'describing' 'each' 'circle?
echo end' 'type' 'group
echo 
echo type' '::' 'property
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'value,' 'sum,' 'sum2,' 'equilibrium
echo ' '' '' '' 'integer' '::' 'count,' 'equilibcount
echo end' 'type' 'property
echo 
echo type' '::' 'node' '
echo ' '' '' '' 'integer' '::' 'rnode,' 'lnode,' 'pnode
echo end' 'type' 'node' '
echo 
echo 
echo 
echo !'*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo !'*''*'' 'GLOBAL' 'VARIABLES
echo !'*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo !' ''*''*'' 'simulation' 'molecules' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'' '
echo type"("group")",' 'dimension"("cube")"' '::' 'square' '!' 'square' 'groupings' 'plus' 'ghost' 'event
echo type"("event")"' '::' 'ghost_event' '!' 'ghost' 'collision' 'event' '
echo !' ''*''*'' 'simulation' 'parameters' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo real"("kind=dbl")"' '::' 'timenow' '!' 'current' 'length' 'of' 'simulation' '
echo real"("kind=dbl")"' '::' 'timeperiod' '!' 'current' 'length' 'of' 'period' '
echo real"("kind=dbl")"' '::' 'ghostrate' '!' 'frequency' 'of' 'ghost' 'collision' '
echo real"("kind=dbl")"' '::' 'tempset' '!' 'current' 'system' 'temperature' 'set' 'point' '
echo integer' '::' 'n_events,' 'n_col,' 'n_ghost,' 'n_bond,' 'n_hard,' 'n_well' '!' 'event' 'counting
echo integer' '::' 'ghost' '!' 'downlist,' 'uplist,' 'and' 'ghost' 'event' 'participants
echo integer' '::' 'anneal' '!' 'number' 'of' 'times' 'the' 'simulation' 'has' 'reduced' 'the' 'temperature
echo !' ''*''*'' 'simulation' 'properties' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo type"("property")"' '::' 'te' '!' 'total' 'energy' '
echo type"("property")"' '::' 'ke' '!' 'kinetic' 'energy' '
echo type"("property")"' '::' 'pot' '!' 'potential' 'energy' '
echo type"("property")"' '::' 'temp' '!' 'temperature
echo type"("property")"' '::' 'pv' '!' 'accumulation
echo type"("property")"' '::' 'z' '!' 'compressibility' 'factor
echo type"("property")",' 'dimension"("ndim")"' '::' 'lm' '!' 'linear' 'momentum' 'in' 'each' 'dimension
echo type"("property")"' '::' 'poly1' '!' 'polyermization' 'with' 'one' 'molecule' 'order' 'parameter
echo type"("property")"' '::' 'poly1aa' '!' 'polymerization' 'of' 'a-chirality' 'squares' 'with' 'different' 'a-chirality' 'squares
echo type"("property")"' '::' 'poly1abba' '!' 'polymerization' 'of' 'squares' 'with' 'oppsosite' 'chirality' 'squares
echo type"("property")"' '::' 'poly1bb' '!' 'polymerization' 'of' 'b-chirality' 'squares' 'with' 'different' 'b-chirality' 'squares
echo type"("property")"' '::' 'h2ts' '!' 'head' 'to' 'tail' '-' 'same' 'order' 'parameter' '
echo type"("property")"' '::' 'h2to' '!' 'head' 'to' 'tail' '-' 'opposite' 'order' 'parameter
echo type"("property")"' '::' 'anti' '!' 'anti-parallel' 'order' 'parameter
echo type"("property")"' '::' 'poly2' '!' 'polymerization' 'with' 'two' 'molecules' 'order' 'parameter
echo type"("property")"' '::' 'full' '!' 'fully-assembled' 'order' 'parameter
echo type"("property")"' '::' 'fulls' '!' 'fully' 'assembled' 'order' 'parameter' 'for' 'same' 'chiralities' '
echo type"("property")"' '::' 'fullo' '!' 'fully' 'assembled' 'order' 'parameter' 'for' 'same' 'and' 'opposite' 'chiralities
echo type"("property")"' '::' 'percy' '!' 'percolation' 'order' 'parameter
echo type"("property")"' '::' 'nclust' '!' 'number' 'of' 'clusters' 'identified' 'by' 'percolation' 'algorithm' '
echo type"("property")"' '::' 'nematic' '!' 'nematic' 'order' 'parameter' 'between' 'all' 'squares
echo !' ''*''*'' 'efficiency' 'methods' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo real"("kind=dbl")"' '::' 'dispTotal' '!' 'displacement' 'of' 'fastest' 'particle' 'between' 'neighborlist' 'updates
echo logical' '::' 'nbrnow' '!' 'update' 'neighbor' 'list?
echo type"("node")",' 'dimension"("mols+1")"' '::' 'eventTree' '!' 'binary' 'tree' 'list' 'used' 'for' 'scheduling' 'collision' 'events
echo integer' '::' 'rootnode' '!' 'pointer' 'to' 'first' 'node' 'of' 'binary' 'tree' 'using' 'for' 'scheduling' 'collision' 'events
echo real"("kind=dbl")"' '::' 'tsl,' 'tl' '!' 'used' 'for' 'false' 'positioning' 'method:' 'time' 'since' 'last' 'update' 'and' 'time' 'of' 'last' 'update
echo 
echo 
echo 
echo !'*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo !'*''*'' 'GLOBAL' 'METHODS
echo !'*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo contains' '
echo 
echo !' ''*''*'' 'type"("id")"' 'functions' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo type"("id")"' 'function' 'nullset"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' 'nullset'%'one' '=' '0
echo ' '' '' '' 'nullset'%'two' '=' '0
echo end' 'function' 'nullset
echo 
echo integer' 'function' 'id2mol"("i,' 'm")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'i,' 'm
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' 'id2mol' '=' '"("i-1")"'*'mer' '+' 'm
echo end' 'function' 'id2mol
echo 
echo type"("id")"' 'function' 'mol2id"("i")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'i
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' 'mol2id'%'one' '=' '"(""("i' '-' '1")"' '/' 'mer")"' '+' '1
echo ' '' '' '' 'mol2id'%'two' '=' 'mod"("i,' 'mer")"
echo ' '' '' '' 'if' '"("mol2id'%'two' '==' '0")"' 'mol2id'%'two' '=' 'mer
echo end' 'function' 'mol2id
echo 
echo logical' 'function' 'idequiv"("id1,' 'id2")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("id")",' 'intent"("in")"' '::' 'id1,' 'id2
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' 'idequiv' '=' '"("id1'%'one' '==' 'id2'%'one")"' '.and.' '"("id1'%'two' '==' 'id2'%'two")"
echo end' 'function' 'idequiv
echo 
echo 
echo !' ''*''*'' 'type"("event")"' 'functions' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo type"("event")"' 'function' 'reset_event' '"("")"' '
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' 'reset_event'%'time' '=' 'bigtime
echo ' '' '' '' 'reset_event'%'type' '=' '0
echo ' '' '' '' 'reset_event'%'partner' '=' 'nullset' '"("")"
echo end' 'function' 'reset_event
echo 
echo logical' 'function' 'sooner' '"("newevent,' 'oldevent")"' '
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("event")",' 'intent"("in")"' '::' 'newevent
echo ' '' '' '' 'type"("event")",' 'intent"("in")"' '::' 'oldevent
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' 'sooner' '=' 'newevent'%'time' ''<'' 'oldevent'%'time' '
echo end' 'function' 'sooner
echo 
echo 
echo !' ''*''*'' 'initialization' '/' 'restarting' '/' 'saving' '/' 'loading' ''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo subroutine' 'initialize_system' '"("")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' '!' 'open' 'simulation' 'files
echo ' '' '' '' 'call' 'set_annealstatus' '"("")"
echo ' '' '' '' 'if' '"("tempset' ''<'=' 'tempfinal")"' 'call' 'exit"("")"' '!' 'DONE:' 'prevent' 'the' 'system' 'from' 'simulating' 'below' 'the' 'maximum
echo ' '' '' '' 'call' 'open_files' '"("")"
echo 
echo ' '' '' '' '!' 'initialize' 'groupings
echo ' '' '' '' 'call' 'initial_state' '"("")"
echo ' '' '' '' 'call' 'set_position' '"("")"
echo ' '' '' '' 'call' 'set_velocity' '"("")"
echo ' '' '' '' 'call' 'set_chairality' '"("")"
echo ' '' '' '' 'call' 'set_polarity' '"("")"
echo ' '' '' '' 'call' 'build_neighborlist' '"("")"
echo ' '' '' '' 'call' 'set_orderlist' '"("")"
echo 
echo ' '' '' '' '!' 'initialize' 'system' 'properties' '
echo ' '' '' '' 'call' 'initialize_properties' '"("")"
echo 
echo ' '' '' '' '!' 'save
echo ' '' '' '' 'call' 'save"("")"
echo 
echo ' '' '' '' 'write"("simiounit,'*'")"' '\''*''*''*'' 'START' 'OF' 'DISCONTINUOUS' 'MOLECULAR' 'DYNAMICS' ''*''*''*'\'
echo ' '' '' '' 'write"("simiounit,'*'")"' '\'' '\'
echo ' '' '' '' 'write"("simiounit,'*'")"' '\'' '' '' '' 's' '' '' ''|'' '' '' 'steps' '' '' ''|'' '' '' 'te' '' '' ''|'' '' '' 'pe' '' '' ''|'' '' '' 'ke' '' '' ''|'' '' 'temp' '' ''|'' '' '' 'lm' '' '' ''|'' '' '' 'z' '' '' '\'
echo ' '' '' '' 'write"("simiounit,'*'")"' '\'============================================================================\'
echo end' 'subroutine' 'initialize_system
echo 
echo subroutine' 'restart"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' 'call' 'reset_state"("")"
echo ' '' '' '' 'call' 'set_position"("")"
echo ' '' '' '' 'call' 'random_velocity"("0.,' 'sqrt"("tempset")"")"
echo ' '' '' '' 'call' 'set_chairality"("")"
echo ' '' '' '' 'call' 'set_polarity"("")"
echo ' '' '' '' 'call' 'build_neighborlist"("")"
echo ' '' '' '' 'call' 'set_orderlist"("")"
echo ' '' '' '' 'call' 'complete_reschedule"("")"
echo end' 'subroutine' 'restart
echo 
echo subroutine' 'save"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' 'call' 'save_annealstatus' '"("")"
echo ' '' '' '' 'call' 'save_state"("")"
echo ' '' '' '' 'call' 'save_position"("")"
echo ' '' '' '' 'call' 'save_velocity"("")"
echo ' '' '' '' 'call' 'save_chairality"("")"
echo end' 'subroutine' 'save
echo 
echo subroutine' 'adjust_temperature"("temp")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")",' 'intent"("inout")"' '::' 'temp
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '
echo ' '' '' '' 'if' '"("temp' ''>'' '"("0.5")"")"' 'then' '
echo ' '' '' '' '' '' '' '' 'temp' '=' 'temp' '-' '"("0.25")"
echo ' '' '' '' 'else' 'if' '"("temp' ''>'' '"("0.25")"")"' 'then' '
echo ' '' '' '' '' '' '' '' 'temp' '=' 'temp' '-' '"("0.0125")"
echo ' '' '' '' 'else' 'if' '"("temp' ''>'' '"("0.0025")"")"' 'then
echo ' '' '' '' '' '' '' '' 'temp' '=' 'temp' '-' '"("0.005")"
echo ' '' '' '' 'else' '
echo ' '' '' '' '' '' '' '' 'write' '"("simiounit,' ''*'")"' '\'adjust_temperature:' 'temperature' 'for' 'simulation' 'below' 'the' 'allowable' 'amount.' 'Aborting' 'simulation\'
echo ' '' '' '' '' '' '' '' 'call' 'exit' '"("")"
echo ' '' '' '' 'end' 'if' '
echo ' '' '' '' 'call' 'random_velocity"("0.,' 'sqrt"("tempset")"")"
echo ' '' '' '' 'call' 'complete_reschedule"("")"
echo end' 'subroutine' 'adjust_temperature
echo 
echo !' '//' 'anneal' 'status' '//
echo 
echo subroutine' 'set_annealstatus"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'ierror' '
echo 
echo ' '' '' '' '!' 'load' 'the' 'state' 'of' 'the' 'annealing' 'simulation
echo ' '' '' '' 'open' '"("unit' '=' 'saveiounit,' 'file' '=' 'trim"("annealsavefile")",' 'status' '=' '\'OLD\',' 'action' '=' '\'READ\',' 'iostat' '=' 'ierror")"
echo ' '' '' '' 'if' '"("ierror' '==' '0")"' 'then' '!' 'read' 'the' 'information' 'in' 'from' 'the' 'save' 'file' '
echo ' '' '' '' '' '' '' '' 'read' '"("saveiounit,' ''*'")"' 'anneal' '
echo ' '' '' '' '' '' '' '' 'read' '"("saveiounit,' ''*'")"' 'tempset' '
echo ' '' '' '' '' '' '' '' 'close' '"("unit' '=' 'saveiounit,' 'status' '=' '\'KEEP\'")"
echo ' '' '' '' 'else' '!' 'if' 'not' 'save' 'status' 'for' 'the' 'anneal' 'simulation' 'exists,' 'start' 'the' 'simulation' 'from' 'the' 'beginning' '
echo ' '' '' '' '' '' '' '' 'anneal' '=' '0
echo ' '' '' '' '' '' '' '' 'tempset' '=' 'tempstart
echo ' '' '' '' 'end' 'if' '
echo end' 'subroutine' 'set_annealstatus
echo 
echo subroutine' 'save_annealstatus"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'ierror' '
echo 
echo ' '' '' '' '!' 'save' 'the' 'status' 'of' 'the' 'annealing' 'simulation
echo ' '' '' '' 'open' '"("unit' '=' 'saveiounit,' 'file' '=' 'trim"("annealsavefile")",' 'status' '=' '\'REPLACE\',' 'action' '=' '\'WRITE\',' 'iostat' '=' 'ierror")"
echo ' '' '' '' 'if' '"("ierror' '==' '0")"' 'then' '
echo ' '' '' '' '' '' '' '' 'write' '"("saveiounit,' ''*'")"' 'anneal
echo ' '' '' '' '' '' '' '' 'write' '"("saveiounit,' ''*'")"' 'tempset
echo ' '' '' '' 'else
echo ' '' '' '' '' '' '' '' 'write' '"("simiounit,' ''*'")"' '\'save_state:' 'unable' 'to' 'open' 'annealsavefile.' 'failed' 'to' 'record' 'annealing' 'simulation' 'status\'
echo ' '' '' '' 'end' 'if
echo end' 'subroutine' 'save_annealstatus
echo 
echo !' '//' 'state' '//
echo 
echo subroutine' 'reset_state"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'ierror' '
echo 
echo ' '' '' '' '!' 'load' 'simulation' 'state
echo ' '' '' '' 'open' '"("unit' '=' 'saveiounit,' 'file' '=' 'trim"("simsavefile")",' 'status' '=' '\'OLD\',' 'action' '=' '\'READ\',' 'iostat' '=' 'ierror")"
echo ' '' '' '' 'if' '"("ierror' '==' '0")"' 'then' '
echo ' '' '' '' '' '' '' '' 'read"("saveiounit,' ''*'")"' 'timenow
echo ' '' '' '' '' '' '' '' 'read"("saveiounit,' ''*'")"' 'timeperiod
echo ' '' '' '' '' '' '' '' 'read"("saveiounit,' ''*'")"' 'tempset
echo ' '' '' '' '' '' '' '' 'read"("saveiounit,' ''*'")"' 'tl
echo ' '' '' '' '' '' '' '' 'read"("saveiounit,' ''*'")"' 'n_events
echo ' '' '' '' '' '' '' '' 'read"("saveiounit,' ''*'")"' 'n_col
echo ' '' '' '' '' '' '' '' 'read"("saveiounit,' ''*'")"' 'n_ghost
echo ' '' '' '' '' '' '' '' 'read"("saveiounit,' ''*'")"' 'n_bond
echo ' '' '' '' '' '' '' '' 'read"("saveiounit,' ''*'")"' 'n_hard
echo ' '' '' '' '' '' '' '' 'read"("saveiounit,' ''*'")"' 'n_well
echo ' '' '' '' '' '' '' '' 'close' '"("unit' '=' 'saveiounit,' 'status' '=' '\'KEEP\'")"
echo ' '' '' '' 'else' '
echo ' '' '' '' '' '' '' '' '!' 'if' 'no' 'save' 'file' 'exists,' 'restart' 'simulation' 'from' 'the' 'beginning
echo ' '' '' '' '' '' '' '' 'call' 'initial_state"("")"
echo ' '' '' '' 'endif
echo end' 'subroutine' 'reset_state
echo 
echo subroutine' 'initial_state"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'ierror' '!' 'used' 'to' 'record' 'the' 'status' 'of' 'i/o' 'operations
echo 
echo ' '' '' '' '!' 'intialize' 'simulation' 'event' 'and' 'time' 'tracking' 'to' 'zero
echo ' '' '' '' 'timenow' '=' '0.
echo ' '' '' '' 'timeperiod' '=' '0.
echo ' '' '' '' 'tl' '=' '0.
echo ' '' '' '' 'n_events' '=' '0
echo ' '' '' '' 'n_col' '=' '0
echo ' '' '' '' 'n_ghost' '=' '0
echo ' '' '' '' 'n_bond' '=' '0
echo ' '' '' '' 'n_hard' '=' '0
echo ' '' '' '' 'n_well' '=' '0
echo end' 'subroutine' 'initial_state
echo 
echo subroutine' 'save_state"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'ierror' '
echo 
echo ' '' '' '' '!' 'save' 'the' 'state' 'of' 'the' 'simulation' '
echo ' '' '' '' 'open' '"("unit' '=' 'saveiounit,' 'file' '=' 'trim"("simsavefile")",' 'status' '=' '\'REPLACE\',' 'action' '=' '\'WRITE\',' 'iostat' '=' 'ierror")"
echo ' '' '' '' 'if' '"("ierror' '==' '0")"' 'then' '
echo ' '' '' '' '' '' '' '' 'write"("saveiounit,' ''*'")"' 'timenow
echo ' '' '' '' '' '' '' '' 'write"("saveiounit,' ''*'")"' 'timeperiod
echo ' '' '' '' '' '' '' '' 'write"("saveiounit,' ''*'")"' 'tempset
echo ' '' '' '' '' '' '' '' 'write"("saveiounit,' ''*'")"' 'tl
echo ' '' '' '' '' '' '' '' 'write"("saveiounit,' ''*'")"' 'n_events
echo ' '' '' '' '' '' '' '' 'write"("saveiounit,' ''*'")"' 'n_col
echo ' '' '' '' '' '' '' '' 'write"("saveiounit,' ''*'")"' 'n_ghost
echo ' '' '' '' '' '' '' '' 'write"("saveiounit,' ''*'")"' 'n_bond
echo ' '' '' '' '' '' '' '' 'write"("saveiounit,' ''*'")"' 'n_hard
echo ' '' '' '' '' '' '' '' 'write"("saveiounit,' ''*'")"' 'n_well
echo ' '' '' '' '' '' '' '' 'close"("unit' '=' 'saveiounit,' 'status' '=' '\'KEEP\'")"
echo ' '' '' '' 'else' '
echo ' '' '' '' '' '' '' '' 'write"("simiounit,' ''*'")"' '\'save_state:' 'unable' 'to' 'open' 'simsavefile.' 'failed' 'to' 'record' 'simulation' 'state' 'data\'
echo ' '' '' '' 'endif
echo end' 'subroutine' 'save_state
echo 
echo !' '//' 'position' '//
echo 
echo subroutine' 'set_position' '"("")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer,' 'parameter' '::' 'max_attempts' '=' '1' '!' 'maximum' 'number' 'of' 'times' 'to' 'attempt' 'generating' 'a' 'random' 'configuration
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'q' '!' 'indexing' 'parameters' 'for' 'reading' 'saved' 'file' 'data' '
echo ' '' '' '' 'integer' '::' 'success' '!' 'used' 'to' 'determine' 'if' 'random' 'walk' 'algorithm' 'was' 'successful' '
echo ' '' '' '' 'integer' '::' 'attempts' '!' 'used' 'to' 'count' 'the' 'number' 'of' 'times' 'random' 'walk' 'algorithm' 'has' 'been' 'attempted
echo ' '' '' '' 'integer' '::' 'ierror' '!' 'used' 'to' 'record' 'the' 'status' 'of' 'i/o' 'operations' '
echo 
echo ' '' '' '' '!' 'if' 'a' 'file' 'containing' 'the' 'simulation' 'postion' 'data' 'exists,' 'read' 'it' 'in
echo ' '' '' '' 'open' '"("unit' '=' 'saveiounit,' 'file' '=' 'trim"("fpossavefile")",' 'status' '=' '\'OLD\',' 'action' '=' '\'READ\',' 'iostat' '=' 'ierror")"
echo ' '' '' '' 'if' '"("ierror' '==' '0")"' 'then' '!' 'read' 'in' 'the' 'information' 'from' 'the' 'save' 'file' '
echo ' '' '' '' '' '' '' '' 'write"("simiounit,'*'")"' '\'set_position:' 'postion' 'vectors' 'were' 'read' 'from' 'saveio' 'file\'
echo ' '' '' '' '' '' '' '' 'read' '"("saveiounit,' ''*'")"' 'tsl
echo ' '' '' '' '' '' '' '' 'do' 'q' '=' '1' ',' 'ndim' '!' 'for' 'each' 'dimension' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'i' '=' '1,' 'cube' '!' 'for' 'each' 'square' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '!' 'for' 'each' 'particle' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'read' '"("saveiounit,' ''*'")"' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("q")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' 'end' 'do
echo ' '' '' '' '' '' '' '' 'close' '"("unit' '=' 'saveiounit,' 'status' '=' '\'KEEP\'")"
echo ' '' '' '' 'else' 'if' '"(""("ierror' '/=' '0")"' '.or.' '"("check_boundaries"("")"")"")"' 'then' '!' 'if' 'the' 'file' 'could' 'not' 'be' 'loaded' 'or' 'the' 'boundaries' 'are' 'overlapping
echo ' '' '' '' '' '' '' '' '!' 'generate' 'random' 'configuration
echo ' '' '' '' '' '' '' '' 'attempts' '=' '0
echo ' '' '' '' '' '' '' '' 'do
echo ' '' '' '' '' '' '' '' '' '' '' '' 'attempts' '=' 'attempts' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' 'success' '=' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' 'call' 'random_position' '"("success")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("success' '==' '1")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write"("simiounit,'*'")"' '\'set_position:' 'position' 'vectors' 'were' 'generated' 'using' 'random' 'walk' 'algorithm\'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'exit
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"(""("success' '==' '0")"' '.and.' '"("attempts' ''>'=' 'max_attempts")"")"' 'then
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write"("simiounit,'*'")"' '\'set_position:' 'algorithm' 'unable' 'to' 'generate' 'squares' 'with' 'random' 'positions' 'at' 'given' 'density.\'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write"("simiounit,'*'")"' '\'set_position:' 'squares' 'were' 'generated' 'into' 'a' 'bcc' 'lattice' 'formation.\'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'lattice' '"("")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'exit
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' 'end' 'if
echo end' 'subroutine' 'set_position
echo 
echo subroutine' 'random_position' '"("success")"' '
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer,' 'intent"("out")"' '::' 'success' '
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer,' 'parameter' '::' 'limit' '=' '100000' '!' 'maxumimum' 'number' 'of' 'attempts' 'algorithm' 'giving' 'up
echo ' '' '' '' 'integer' '::' 'count' '!' 'number' 'of' 'atempts' 'made' 'at' 'random' 'position' 'generation
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'rij,' 'theta' '!' 'distance' 'between' 'two' 'particle,' 'angle' 'relative' 'to' 'origin
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'u,' 'x,' 'y' '!' 'variables' 'for' 'random' 'position' 'and' 'orientation
echo ' '' '' '' 'integer' '::' 'overlap' '!' 'if' 'overlap,' '1
echo ' '' '' '' 'integer' '::' 'i,' 'j,' 'm,' 'n,' 'q,' 'r' '!' 'indexing' 'parameters
echo 
echo ' '' '' '' '!' 'Initialize' 'parameteres
echo ' '' '' '' 'count' '=' '0' '!' 'initial' 'attempts' 'are' 'zero
echo ' '' '' '' 'success' '=' '0' '!' 'initially' 'unsuccessful' 'until' 'successful
echo 
echo ' '' '' '' 'i' '=' '1' '!' 'first' 'cube' '
echo ' '' '' '' 'do' '!' 'for' 'every' 'cube
echo ' '' '' '' '' '' '' '' 'overlap' '=' '0
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '!' 'for' 'every' 'sphere' 'making' 'up' 'a' 'cube' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'assemble' 'spheres' 'in' 'a' 'cube' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("m' '==' '1")"' 'then' '!' 'if' 'the' 'cube' 'is' 'the' 'first' 'in' 'the' 'assembly
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'give' 'the' 'first' 'sphere' 'a' 'random' 'position' 'and' 'orientation
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'random_number' '"("theta")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'theta' '=' 'theta' ''*'' '360
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'random_number' '"("square"("i")"'%'circle"("m")"'%'fpos'%'r"("q")"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("q")"' '=' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("q")"' ''*'' 'region
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'assign' 'positions' 'based' 'on' 'previous' 'positions' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'spheres' 'are' 'generated' 'in' 'a' 'counter' 'clockwise' 'fashion
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("1")"' '=' 'square"("i")"'%'circle"("m' '-' '1")"'%'fpos'%'r"("1")"' '+' 'sigma1' ''*'' 'cos"("theta' '+' '"("m' '-' '1")"' ''*'' 'halfpi")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("2")"' '=' 'square"("i")"'%'circle"("m' '-' '1")"'%'fpos'%'r"("2")"' '+' 'sigma1' ''*'' 'sin"("theta' '+' '"("m' '-' '1")"' ''*'' 'halfpi")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'apply_periodic_boundaries"("square"("i")"'%'circle"("m")"'%'fpos")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo 
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'check' 'that' 'the' 'new' 'sphere' 'does' 'not' 'overlap' 'with' 'any' 'previous' 'squares
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("i'>'1")"' 'then' '!' 'if' 'the' 'spheres' 'do' 'not' 'belong' 'to' 'the' 'first' 'cube
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'j' '=' '1,' 'i-1' '!' 'for' 'all' 'already' 'placed' 'squares
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'n' '=' '1,' 'mer' '!' 'for' 'all' 'spheres' 'in' 'each' 'square
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'rij' '=' 'distance"("square"("i")"'%'circle"("m")",' 'square"("j")"'%'circle"("n")"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("sqrt"("rij")"' ''<'' 'sigma1")"' 'overlap' '=' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' 'end' 'do
echo 
echo ' '' '' '' '' '' '' '' 'if' '"("overlap' '==' '0")"' 'then
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("i' '==' 'cube")"' 'then' '!' 'if' 'all' 'squares' 'have' 'been' 'randomly' 'places' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'success' '=' '1' '!' 'the' 'algorithm' 'has' 'been' 'successful
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'tsl' '=' '0.' '!' 'the' 'time' 'since' 'the' 'last' 'update' 'is' 'reset
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'tl' '=' 'timenow' '!' 'the' 'time' 'of' 'the' 'last' 'update' 'is' 'the' 'current' 'time
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'return' '!' 'leave' 'the' 'subroutine
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if
echo ' '' '' '' '' '' '' '' '' '' '' '' 'i' '=' 'i' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' 'count' '=' '0
echo ' '' '' '' '' '' '' '' 'else' '!' 'the' 'one' 'of' 'the' 'four' 'spheres' 'is' 'overlapping
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'assign' 'the' 'first' 'sphere' 'of' 'cube' 'i' 'a' 'new' 'position' 'and' 'orientation
echo ' '' '' '' '' '' '' '' '' '' '' '' 'count' '=' 'count' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("count' ''>'' 'limit")"' 'then' '!' 'if' 'the' 'maximum' 'number' 'of' 'trials' 'has' 'been' 'reached
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'return' '!' 'leave' 'subroutine
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' 'end' 'do
echo end' 'subroutine' 'random_position
echo 
echo subroutine' 'lattice' '"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")",' 'parameter' '::' 'ori' '=' '"("225.' '/' '360.")"' ''*'' 'twopi' '!' 'orientation' 'of' 'the' 'cube' '[radians]
echo ' '' '' '' 'real"("kind=dbl")",' 'parameter' '::' 'radius' '=' 'sqrt"("2.")"' '/' '2.' '!' 'distance' 'from' 'square' 'center' 'to' 'sphere' 'center
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'distance' '!' 'measurement' 'of' 'distance' 'between' 'two' 'particles
echo ' '' '' '' 'real' '::' 'rand' '!' 'random' 'number
echo ' '' '' '' 'integer' '::' 'randori' '!' 'random' 'orientation' 'created' 'by' 'the' 'random' 'number
echo ' '' '' '' 'type"("position")"' '::' 'dr,' 'center
echo ' '' '' '' 'integer' '::' 'x,' 'y,' 'm' '' '!' 'indexing' 'parameters
echo 
echo 
echo ' '' '' '' 'tsl' '=' '0.' '!' 'the' 'time' 'since' 'the' 'last' 'update' 'is' 'reset
echo ' '' '' '' 'tl' '=' 'timenow' '!' 'the' 'time' 'of' 'the' 'last' 'update' 'is' 'the' 'current' 'time
echo 
echo ' '' '' '' 'x_axis:' 'do' 'x' '=' '1,' 'cell' '
echo ' '' '' '' '' '' '' '' 'center'%'r"("1")"' '=' '"("region' '/' 'real"("cell")"")"' ''*'' '"("real"("x")"' '-' '0.5")"
echo ' '' '' '' '' '' '' '' 'y_axis:' 'do' 'y' '=' '1,' 'cell' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'center'%'r"("2")"' '=' '"("region' '/' 'real"("cell")"")"' ''*'' '"("real"("y")"' '-' '0.5")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'call' 'random_number' '"("rand")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'randori' '=' 'floor' '"("rand' ''*'' '4.")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'group:' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'spheres' 'are' 'generated' 'in' 'a' 'counter' 'clockwise' 'fashion
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"(""("x' '-' '1")"' ''*'' 'cell' '+' 'y")"'%'circle"("m")"'%'fpos'%'r"("1")"' '=' 'center'%'r"("1")"' '+' 'radius' ''*'' 'cos"("ori' '+' ''&'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '"("real"("randori")"' ''*'' 'halfpi")"' '+' '"("m' '-' '1")"' ''*'' 'halfpi")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"(""("x' '-' '1")"' ''*'' 'cell' '+' 'y")"'%'circle"("m")"'%'fpos'%'r"("2")"' '=' 'center'%'r"("2")"' '+' 'radius' ''*'' 'sin"("ori' '+' ''&'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '"("real"("randori")"' ''*'' 'halfpi")"' '+' '"("m' '-' '1")"' ''*'' 'halfpi")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' 'group
echo ' '' '' '' '' '' '' '' 'end' 'do' 'y_axis
echo ' '' '' '' 'end' 'do' 'x_axis
echo end' 'subroutine' 'lattice
echo 
echo subroutine' 'save_position"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'ierror' '!' 'used' 'to' 'determine' 'read/write' 'error' 'status' '
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'q' '!' 'used' 'for' 'indexing' '
echo 
echo ' '' '' '' 'open' '"("unit' '=' 'saveiounit,' 'file' '=' 'fpossavefile,' 'status' '=' '\'REPLACE\',' 'action' '=' '\'WRITE\',' 'iostat' '=' 'ierror")"
echo ' '' '' '' 'if' '"("ierror' '==' '0")"' 'then' '
echo ' '' '' '' '' '' '' '' 'write' '"("saveiounit,' ''*'")"' 'tsl
echo ' '' '' '' '' '' '' '' 'do' 'q' '=' '1' ',' 'ndim' '!' 'for' 'each' 'dimension' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'i' '=' '1,' 'cube' '!' 'for' 'each' 'square' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '!' 'for' 'each' 'particle' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("saveiounit,' ''*'")"' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("q")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '' '' '' '' 'enddo' '
echo ' '' '' '' '' '' '' '' 'enddo' '
echo ' '' '' '' '' '' '' '' 'close' '"("unit' '=' 'saveiounit,' 'status' '=' '\'KEEP\'")"
echo ' '' '' '' 'else' '
echo ' '' '' '' '' '' '' '' 'write' '"("simiounit,'*'")"' '\'save_position:' 'unable' 'to' 'open' 'file.' 'failed' 'to' 'record' 'simulation' 'position' 'data\'
echo ' '' '' '' 'end' 'if' '
echo end' 'subroutine' 'save_position
echo 
echo !' '//' 'velocity' '//
echo 
echo subroutine' 'set_velocity' '"("")"' '
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'q' '!' 'indexing' 'parameters' 'for' 'reading' 'saved' 'file' 'data' '
echo ' '' '' '' 'integer' '::' 'ierror' '!' 'used' 'to' 'record' 'the' 'status' 'of' 'i/o' 'operations' '
echo 
echo ' '' '' '' '!' 'if' 'a' 'file' 'containing' 'the' 'simulation' 'velocity' 'data' 'exists,' 'read' 'it' 'in
echo ' '' '' '' 'open' '"("unit' '=' 'saveiounit,' 'file' '=' 'trim"("velsavefile")",' 'status' '=' '\'OLD\',' 'action' '=' '\'READ\',' 'iostat' '=' 'ierror")"
echo ' '' '' '' 'if' '"("ierror' '==' '0")"' 'then' '!' 'read' 'in' 'the' 'information' 'from' 'the' 'save' 'file' '
echo ' '' '' '' '' '' '' '' 'write"("simiounit,'*'")"' '\'set_velocity:' 'velocity' 'vectors' 'were' 'read' 'from' 'saveio' 'file\'
echo ' '' '' '' '' '' '' '' 'do' 'q' '=' '1' ',' 'ndim' '!' 'for' 'each' 'dimension' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'i' '=' '1,' 'cube' '!' 'for' 'each' 'square' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '!' 'for' 'each' 'particle' 'in' 'each' 'grouping
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'read' '"("saveiounit,' ''*'")"' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' 'end' 'do
echo ' '' '' '' '' '' '' '' 'close' '"("unit' '=' 'saveiounit,' 'status' '=' '\'KEEP\'")"
echo ' '' '' '' 'else' '!' 'assign' 'velocities' '
echo ' '' '' '' '' '' '' '' 'call' 'random_velocity' '"("0.,' 'sqrt"("tempset")"")"
echo ' '' '' '' 'end' 'if
echo end' 'subroutine' 'set_velocity
echo 
echo subroutine' 'random_velocity' '"("mu,' 'sigma")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real,' 'intent"("in")"' '::' 'mu' '!' 'mean' 'of' 'distribution
echo ' '' '' '' 'real"("kind=dbl")",' 'intent"("in")"' '::' 'sigma' '!' 'standard' 'deviation' 'of' 'distribution
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("position")",' 'dimension"("mols")"' '::' 'rpos' '!' 'array' 'storing' 'the' 'real' 'position' 'of' 'every' 'particle' 'whose' 'position' 'is' 'being' 'update
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'q' '!' 'indexing' 'parameters
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'u_1,' 'u_2' '!' 'Box-Mueller' 'algorithm' 'parameters
echo ' '' '' '' 'type"("velocity")"' '::' 'vsum
echo 
echo ' '' '' '' 'do' 'q' '=' '1,' 'ndim
echo ' '' '' '' '' '' '' '' 'vsum'%'v"("q")"' '=' '0.
echo ' '' '' '' 'end' 'do' '
echo 
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube' '!' 'for' 'each' 'group' '
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '!' 'for' 'each' 'particle
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'store' 'the' 'real' 'position' 'of' 'each' 'particle
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'rpos"("id2mol"("i,m")"")"'%'r"("q")"' '=' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("q")"' '+' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"' ''*'' 'tsl
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'Generate' 'a' 'pseudo' 'random' 'vector' 'components' 'based' 'on' 'a' 'Gaussian' 'distribution' 'along' 'the' 'Box-Mueller' 'algorithm
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'random_number' '"("u_1")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'random_number' '"("u_2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'assign' 'random' 'velocity' 'component' 'to' 'each' 'sphere' 'in' 'cube
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"' '=' 'mu' '+' 'sigma' ''*'' 'sqrt"("' '-2.' ''*'' 'log"("u_1")"")"' ''*'' 'sin' '"("twopi' ''*'' 'u_2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'vsum'%'v"("q")"' '=' 'vsum'%'v"("q")"' '+' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' 'end' 'do' '
echo 
echo ' '' '' '' '!' 'calculate' 'the' 'linear' 'momentum' 'contributions' 'per' 'molecule' 'in' 'each' 'direction
echo ' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' 'vsum'%'v"("q")"' '=' 'vsum'%'v"("q")"' '/' 'mols
echo ' '' '' '' 'end' 'do' '
echo 
echo ' '' '' '' '!' 'reduce' 'the' 'velocity' 'sum' '/' 'linear' 'momentum' 'to' 'zero
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube' '!' 'for' 'each' 'group' '
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '!' 'for' 'each' 'sphere' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"' '=' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"' '-' 'vsum'%'v"("q")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' 'end' 'do
echo ' '' '' '' 'end' 'do
echo 
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'new' 'false' 'position' 'of' 'each' 'particle
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("q")"' '=' 'rpos"("id2mol"("i,m")"")"'%'r"("q")"' '-' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"' ''*'' 'tsl
echo ' '' '' '' '' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'apply' 'periodic' 'boundary' 'conditions
echo ' '' '' '' '' '' '' '' '' '' '' '' 'call' 'apply_periodic_boundaries"("square"("i")"'%'circle"("m")"'%'fpos")"
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' 'enddo
echo end' 'subroutine' 'random_velocity
echo 
echo subroutine' 'save_velocity"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'ierror' '!' 'used' 'to' 'determine' 'read/write' 'error' 'status' '
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'q' '!' 'used' 'for' 'indexing' '
echo 
echo ' '' '' '' 'open' '"("unit' '=' 'saveiounit,' 'file' '=' 'velsavefile,' 'status' '=' '\'REPLACE\',' 'action' '=' '\'WRITE\',' 'iostat' '=' 'ierror")"
echo ' '' '' '' 'if' '"("ierror' '==' '0")"' 'then' '
echo ' '' '' '' '' '' '' '' 'do' 'q' '=' '1' ',' 'ndim' '!' 'for' 'each' 'dimension' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'i' '=' '1,' 'cube' '!' 'for' 'each' 'square' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '!' 'for' 'each' 'particle' 'in' 'each' 'grouping
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("saveiounit,' ''*'")"' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '' '' '' '' 'enddo' '
echo ' '' '' '' '' '' '' '' 'enddo' '
echo ' '' '' '' '' '' '' '' 'close' '"("unit' '=' 'saveiounit,' 'status' '=' '\'KEEP\'")"
echo ' '' '' '' 'else' '
echo ' '' '' '' '' '' '' '' 'write' '"("simiounit,'*'")"' '\'save_velocity:' 'unable' 'to' 'open' 'file.' 'failed' 'to' 'record' 'simulation' 'velocity' 'data\'
echo ' '' '' '' 'end' 'if' '
echo end' 'subroutine' 'save_velocity
echo 
echo !' '//' 'chirality' ''&'' 'polaity' '//
echo 
echo subroutine' 'set_chairality' '"("")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'i,' 'm' '!' 'indexing' 'parameters
echo ' '' '' '' 'integer' '::' 'ierror' '!' 'used' 'to' 'record' 'the' 'status' 'of' 'i/o' 'operations' '
echo ' '' '' '' 'real' '::' 'rand' '!' 'random' 'number
echo 
echo ' '' '' '' '!' 'if' 'a' 'file' 'containing' 'the' 'simulation' 'chirality' 'data' 'exists
echo ' '' '' '' 'OPEN' '"("unit' '=' 'saveiounit,' 'file' '=' 'trim"("chaisavefile")",' 'status' '=' '\'OLD\',' 'action' '=' '\'READ\',' 'iostat' '=' 'ierror")"
echo ' '' '' '' 'if' '"("ierror' '==' '0")"' 'then' '!' 'read' 'in' 'the' 'information' 'from' 'the' 'save' 'file' '
echo ' '' '' '' '' '' '' '' 'do' 'i' '=' '1,' 'cube' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'read' '"("saveiounit,' ''*'")"' 'square"("i")"'%'chai
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' 'close' '"("unit' '=' 'saveiounit,' 'status' '=' '\'KEEP\'")"
echo ' '' '' '' 'else' '!' 'assign' 'chiralities' 'based' 'on' 'the' 'specified' 'mol' 'fraction
echo ' '' '' '' '' '' '' '' '!' 'assign' 'each' 'cube' 'a' 'chirality' 'based' 'on' 'its' 'order
echo ' '' '' '' '' '' '' '' 'do' 'i' '=' '1,' 'cube' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'rand' '=' 'real"("i")"' '/' 'real"("cube")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("rand' ''>'' 'xa")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'chai' '=' '2
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'chai' '=' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '!' 'randomly' 'rearrange' 'the' 'chirality' 'of' 'all' 'cubes
echo ' '' '' '' '' '' '' '' 'do' 'i' '=' '1,' 'cube' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'call' 'random_number' '"("rand")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'rand' '=' 'rand' ''*'' 'real"("cube")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'm' '=' 'square"("i")"'%'chai' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'chai' '=' 'square"("ceiling"("rand")"")"'%'chai' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("ceiling"("rand")"")"'%'chai' '=' 'm' '
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' 'end' 'if' '
echo end' 'subroutine' 'set_chairality
echo 
echo subroutine' 'save_chairality"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'ierror' '!' 'used' 'to' 'determine' 'read/write' 'error' 'status' '
echo ' '' '' '' 'integer' '::' 'i,' 'm' '!' 'used' 'for' 'indexing' '
echo 
echo ' '' '' '' 'open' '"("unit' '=' 'saveiounit,' 'file' '=' 'trim"("chaisavefile")",' 'status' '=' '\'REPLACE\',' 'action' '=' '\'WRITE\',' 'iostat' '=' 'ierror")"
echo ' '' '' '' 'if' '"("ierror' '==' '0")"' 'then' '
echo ' '' '' '' '' '' '' '' 'do' 'i' '=' '1,' 'cube' '!' 'for' 'each' 'square' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("saveiounit,' ''*'")"' 'square"("i")"'%'chai
echo ' '' '' '' '' '' '' '' 'enddo' '
echo ' '' '' '' '' '' '' '' 'close' '"("unit' '=' 'saveiounit,' 'status' '=' '\'KEEP\'")"
echo ' '' '' '' 'else' '
echo ' '' '' '' '' '' '' '' 'write' '"("simiounit,'*'")"' '\'save_chairality:' 'unable' 'to' 'open' 'file.' 'failed' 'to' 'record' 'simulation' 'chairality' 'data\'
echo ' '' '' '' 'end' 'if' '
echo end' 'subroutine' 'save_chairality
echo 
echo subroutine' 'set_polarity' '"("")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'i,' 'm' '!' 'indexing' 'parameters
echo 
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube' '
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"(""(""("square"("i")"'%'chai' '==' '1")"' '.and.' '"("m' '==' '1")"")"' '.or.' '"(""("square"("i")"'%'chai' '==' '2")"' '.and.' '"("m' '==' '2")"")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'pol' '=' '1' '!' 'positive' 'charge
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' 'if' '"(""(""("square"("i")"'%'chai' '==' '2")"' '.and.' '"("m' '==' '1")"")"' '.or.' '"(""("square"("i")"'%'chai' '==' '1")"' '.and.' '"("m' '==' '2")"")"")"' 'then' '' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'pol' '=' '-1' '!' 'negative' 'charge' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'pol' '=' '0
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' 'end' 'do' '
echo end' 'subroutine' 'set_polarity
echo 
echo 
echo !' ''*''*'' '#physics' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo subroutine' 'apply_periodic_boundaries"("ri")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' 'type"("position")",' 'intent"("inout")"' '::' 'ri
echo ' '' '' '' 'integer' '::' 'q' '
echo 
echo ' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' 'if' '"("ri'%'r"("q")"' ''>'=' 'region")"' 'ri'%'r"("q")"' '=' 'ri'%'r"("q")"' '-' 'region' '
echo ' '' '' '' '' '' '' '' 'if' '"("ri'%'r"("q")"' ''<'' '0.0")"' 'ri'%'r"("q")"' '=' 'ri'%'r"("q")"' '+' 'region
echo ' '' '' '' 'end' 'do' '
echo end' 'subroutine' 'apply_periodic_boundaries
echo 
echo logical' 'function' 'check_boundaries"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'j1,' 'n' '!' 'atomic' 'pairs
echo ' '' '' '' 'type"("id")"' '::' 'a,' 'b' '!' 'group' 'pairs' '
echo ' '' '' '' 'type"("position")"' '::' 'dr' '!' 'difference' 'between' 'two' 'position' 'vectors
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'd' '!' 'scalar' 'distance' 'between' 'two' 'particles
echo ' '' '' '' 'logical' '::' 'check_overlap,' 'check_bond,' 'check_bc' '!' 'integers' 'indicating' 'whether' 'the' 'spheres' 'are' 'overlapping' 'or' 'within' 'the' 'boundary' 'conditions
echo 
echo ' '' '' '' '!' 'initialize' 'checks' '
echo ' '' '' '' 'check_boundaries' '=' '.false.
echo ' '' '' '' 'check_overlap' '=' '.false.
echo ' '' '' '' 'check_bond' '=' '.false.
echo ' '' '' '' 'check_bc' '=' '.false.
echo 
echo ' '' '' '' 'do' 'j1' '=' '1,' 'mols' '
echo ' '' '' '' '' '' '' '' 'a' '=' 'mol2id"("j1")"
echo ' '' '' '' '' '' '' '' '!' 'check' 'that' 'the' 'center' 'of' 'each' 'atom' 'is' 'within' 'the' 'boundary' 'conditions' '
echo ' '' '' '' '' '' '' '' '!if' '"("periodicbounderiesoverlap' '"("square"("a'%'one")"'%'circle"("a'%'two")"")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '!check_bc' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' '!write' '"("simiounit,' '1")"' 'a'%'one,' 'a'%'two,' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'fpos'%'r"("1")",' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'fpos'%'r"("2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '!1' 'format' '"("\"' 'check_boundaries:' 'circle' '\",' 'I3,' '\"' 'of' 'square' '\",' 'I3,' '\"' 'is' 'located' 'outside' 'of' 'the' 'boundaries' '"("\",' 'F6.2,\",' '\",' 'F6.2,\"")".\"")"
echo ' '' '' '' '' '' '' '' '!end' 'if' '
echo ' '' '' '' '' '' '' '' '!' 'loop' 'through' 'all' 'uplist' 'neightbors
echo ' '' '' '' '' '' '' '' 'n' '=' '0
echo ' '' '' '' '' '' '' '' 'compare:' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'n' '=' 'n' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' 'b' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'upnab"("n")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("b'%'one' '==' '0")"' 'exit' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'd' '=' 'distance' '"("square"("a'%'one")"'%'circle"("a'%'two")",' 'square"("b'%'one")"'%'circle"("b'%'two")"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"(""("a'%'one' '==' 'b'%'one")"' '.and.' '"("b'%'two' ''>'' 'a'%'two")"")"' 'then' '!' 'if' 'b' 'is' 'uplist' 'of' 'a' 'and' 'they' 'are' 'on' 'the' 'same' 'group
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'check' 'that' 'all' 'grouped' 'sphere' 'are' 'bonded' 'correctly
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("crossbonded' '"("a'%'two,' 'b'%'two")"' '.and.' 'crossbondoverlap' '"("d")"")"' 'then
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'check_bond' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("simiounit,' '2")"' 'a'%'two,' 'b'%'two,' 'a'%'one,' 'd' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '2' 'format' '"("\"' 'check_boundaries:' 'circles' '\",' 'I3,' '\"' 'and' '\",' 'I3,' '\"' 'of' 'square' '\",' 'I3' ''&'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' ',' '\"' 'are' 'cross-bonded' 'and' 'overlapping' '"("\",' 'F6.4,' '\"")".\"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'else' 'if' '"("neighborbonded' '"("a'%'two,' 'b'%'two")"' '.and.' 'neighborbondoverlap' '"("d")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'check_bond' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("simiounit,' '3")"' 'a'%'two,' 'b'%'two,' 'a'%'one,' 'd' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '3' 'format' '"("\"' 'check_boundaries:' 'circles' '\",' 'I3,' '\"' 'and' '\",' 'I3,' '\"' 'of' 'square' '\",' 'I3' ''&'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' ',' '\"' 'are' 'neighbor-bonded' 'and' 'overlapping' '"("\",' 'F6.2,' '\"")".\"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' 'if' '"("b'%'one' ''>'' 'a'%'one")"' 'then' '!' 'if' 'b' 'is' 'uplist' 'of' 'a' 'and' 'they' 'not' 'on' 'the' 'same' 'group' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("hardsphereoverlap' '"("d")"")"' 'then' '!' 'if' 'the' 'spheres' 'are' 'less' 'than' 'the' 'hard' 'sphere' 'distance' 'apart' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'check_overlap' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("simiounit,' '4")"' 'a'%'two,' 'a'%'one,' 'b'%'two,' 'b'%'one,' 'd
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '4' 'format' '"("\"' 'check_boundaries:' 'circle' '\",' 'I3,' '\"' 'of' 'square' '\",' 'I3,' '\"' 'and' 'circle' '\",' 'I3,' '\"' 'of' 'square' '\",' ''&'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'I3,' '\"' 'are' 'overlapping' '"("\",' 'F6.4,\"")".\"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' 'enddo' 'compare
echo ' '' '' '' 'enddo
echo 
echo ' '' '' '' '!' 'determine' 'if' 'an' 'overlap' 'has' 'occurred' '
echo ' '' '' '' 'if' '"(""("check_bond")"' '.or.' '"("check_overlap")"' '.or.' '"("check_bc")"")"' 'then' '
echo ' '' '' '' '' '' '' '' 'if' '"("check_bc")"' 'write' '"("simiounit,' ''*'")"' '\'check_boundaries:' 'some' 'particles' 'are' 'outside' 'of' 'the' 'periodic' 'boundaries\'
echo ' '' '' '' '' '' '' '' 'if' '"("check_bond")"' 'write' '"("simiounit,' ''*'")"' '\'check_boundaries:' 'some' 'groupings' 'have' 'particles' 'outside' 'their' 'bonds\'
echo ' '' '' '' '' '' '' '' 'if' '"("check_overlap")"' 'write' '"("simiounit,' ''*'")"' '\'check_boundaries:' 'some' 'hardspheres' 'are' 'overlapping' '\'
echo ' '' '' '' '' '' '' '' 'write' '"("simiounit,' ''*'")"' '\'check_boundaries:' 'the' 'program' 'will' 'abort' 'now' '\'
echo ' '' '' '' '' '' '' '' 'check_boundaries' '=' '.true.
echo ' '' '' '' 'end' 'if' '
echo end' 'function' 'check_boundaries
echo 
echo real"("kind=dbl")"' 'function' 'distance' '"("i,' 'j")"' '
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("particle")",' 'intent"("in")"' '::' 'i' '!' 'downlist' 'particle
echo ' '' '' '' 'type"("particle")",' 'intent"("in")"' '::' 'j' '!' 'uplist' 'particle
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("position")"' '::' 'rij
echo ' '' '' '' 'type"("velocity")"' '::' 'vij
echo ' '' '' '' 'integer' '::' 'q' '!' 'indexing' 'parameter' '
echo 
echo ' '' '' '' '!' 'calculate' 'the' 'real' 'distance' 'between' 'the' 'particle' 'pair
echo ' '' '' '' 'distance' '=' '0.' '
echo ' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' 'rij'%'r"("q")"' '=' '"("i'%'fpos'%'r"("q")"' '-' 'j'%'fpos'%'r"("q")"")"
echo ' '' '' '' '' '' '' '' 'vij'%'v"("q")"' '=' '"("i'%'vel'%'v"("q")"' '-' 'j'%'vel'%'v"("q")"")"
echo ' '' '' '' '' '' '' '' 'rij'%'r"("q")"' '=' 'rij'%'r"("q")"' '+' 'vij'%'v"("q")"' ''*'' 'tsl
echo ' '' '' '' '' '' '' '' '!' 'apply' 'the' 'minimum' 'image' 'convention
echo ' '' '' '' '' '' '' '' 'if' '"("rij'%'r"("q")"' ''>'=' '"("0.5' ''*'' 'region")"")"' 'rij'%'r"("q")"' '=' 'rij'%'r"("q")"' '-' 'region' '
echo ' '' '' '' '' '' '' '' 'if' '"("rij'%'r"("q")"' ''<'' '"("-0.5' ''*'' 'region")"")"' 'rij'%'r"("q")"' '=' 'rij'%'r"("q")"' '+' 'region
echo ' '' '' '' '' '' '' '' 'distance' '=' 'distance' '+' '"("rij'%'r"("q")"' ''*''*'' '2")"
echo ' '' '' '' 'end' 'do' '
echo ' '' '' '' 'distance' '=' 'sqrt' '"("distance")"
echo end' 'function' 'distance
echo 
echo type"("position")"' 'function' 'distance_vector"("i,' 'j")"' '!' '#percy
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("particle")",' 'intent"("in")"' '::' 'i' '!' 'downlist' 'particle
echo ' '' '' '' 'type"("particle")",' 'intent"("in")"' '::' 'j' '!' 'uplist' 'particle
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("position")"' '::' 'rij
echo ' '' '' '' 'type"("velocity")"' '::' 'vij
echo ' '' '' '' 'integer' '::' 'q' '!' 'indexing' 'parameter' '
echo 
echo ' '' '' '' '!' 'calculate' 'the' 'relative' 'distance' 'between' 'the' 'pair' 'in' 'each' 'dimension
echo ' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' 'rij'%'r"("q")"' '=' '"("i'%'fpos'%'r"("q")"' '-' 'j'%'fpos'%'r"("q")"")"
echo ' '' '' '' '' '' '' '' 'vij'%'v"("q")"' '=' '"("i'%'vel'%'v"("q")"' '-' 'j'%'vel'%'v"("q")"")"
echo ' '' '' '' '' '' '' '' 'rij'%'r"("q")"' '=' 'rij'%'r"("q")"' '+' 'vij'%'v"("q")"' ''*'' 'tsl
echo ' '' '' '' '' '' '' '' '!' 'apply' 'the' 'minimum' 'image' 'convention
echo ' '' '' '' '' '' '' '' 'if' '"("rij'%'r"("q")"' ''>'=' '"("0.5' ''*'' 'region")"")"' 'rij'%'r"("q")"' '=' 'rij'%'r"("q")"' '-' 'region' '
echo ' '' '' '' '' '' '' '' 'if' '"("rij'%'r"("q")"' ''<'' '"("-0.5' ''*'' 'region")"")"' 'rij'%'r"("q")"' '=' 'rij'%'r"("q")"' '+' 'region
echo ' '' '' '' '' '' '' '' 'distance_vector'%'r"("q")"' '=' 'rij'%'r"("q")"
echo ' '' '' '' 'end' 'do' '
echo end' 'function' 'distance_vector
echo 
echo logical' 'function' 'neighborbonded' '"("i,' 'j")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer,' 'intent' '"("in")"' '::' 'i,' 'j' '!' 'sphere' 'identifiers
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' '!' 'assume' 'false' '
echo ' '' '' '' 'neighborbonded' '=' '.false.
echo ' '' '' '' 'if' '"(""(""("j-i")"' '==' '1")"' '.or.' '"(""("j-i")"' '==' '3")"")"' 'then' '!' 'if' 'the' 'two' 'spheres' 'are' 'next' 'to' 'one' 'another
echo ' '' '' '' '' '' '' '' 'neighborbonded' '=' '.true.
echo ' '' '' '' 'end' 'if' '
echo end' 'function' 'neighborbonded
echo 
echo logical' 'function' 'crossbonded' '"("i,' 'j")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer,' 'intent' '"("in")"' '::' 'i,' 'j' '!' 'sphere' 'identifiers
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' '!' 'assume' 'false' '
echo ' '' '' '' 'crossbonded' '=' '.false.
echo ' '' '' '' 'if' '"(""(""("j-i")"' '==' '2")"' '.and.' '"("i' '==' '1")"")"' 'then' '!' 'if' 'the' 'two' 'spheres' 'are' 'across' 'from' 'one' 'another
echo ' '' '' '' '' '' '' '' 'crossbonded' '=' '.true.
echo ' '' '' '' 'end' 'if' '
echo end' 'function' 'crossbonded
echo 
echo logical' 'function' 'hardsphereoverlap' '"("distance")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")",' 'intent"("in")"' '::' 'distance
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' 'hardsphereoverlap' '=' 'distance' ''<'' '"("sigma1' '-' 'tol")"
echo end' 'function' 'hardsphereoverlap
echo 
echo logical' 'function' 'crossbondoverlap' '"("distance")"' '
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")",' 'intent"("in")"' '::' 'distance' '
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' 'crossbondoverlap' '=' '"("distance' ''>'' '"("ocbond' '+' 'tol")"")"' '.or.' '"("distance' ''<'' '"("icbond' '-' 'tol")"")"
echo end' 'function' 'crossbondoverlap
echo 
echo logical' 'function' 'neighborbondoverlap' '"("distance")"' '
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")",' 'intent"("in")"' '::' 'distance' '
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' 'neighborbondoverlap' '=' '"("distance' ''>'' '"("onbond' '+' 'tol")"")"' '.or.' '"("distance' ''<'' '"("inbond' '-' 'tol")"")"
echo end' 'function' 'neighborbondoverlap
echo 
echo logical' 'function' 'periodicbounderiesoverlap' '"("i")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("particle")"' '::' 'i
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("position")"' '::' 'rpos' '!' 'real' 'position' 'of' 'particle
echo ' '' '' '' 'integer' '::' 'q' '!' 'indexing
echo 
echo ' '' '' '' 'periodicbounderiesoverlap' '=' '.false.' '!' 'false' 'until' 'true' '
echo ' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' 'rpos'%'r"("q")"' '=' 'i'%'fpos'%'r"("q")"' '+' 'i'%'vel'%'v"("q")"' ''*'' 'tsl
echo ' '' '' '' '' '' '' '' 'if' '"(""("rpos'%'r"("q")"' ''>'' '"("region' '+' 'tol")"")"' '.or.' '"("rpos'%'r"("q")"' ''<'' '"("-tol")"")"")"' 'then
echo ' '' '' '' '' '' '' '' '' '' '' '' 'periodicbounderiesoverlap' '=' '.true.
echo ' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' 'end' 'do' '
echo end' 'function' 'periodicbounderiesoverlap
echo 
echo 
echo !' ''*''*'' 'file' 'i/o' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo subroutine' 'open_files' '"("")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'character"("len=10")",' 'parameter' '::' 'format' '=' '\""("I0.3")"\"
echo ' '' '' '' 'character"("len=10")"' '::' 'rp
echo ' '' '' '' 'character"("len=40")"' '::' 'simfile,' 'coorsphfile,' 'coorsqufile,' 'reportfile,' 'annealfile,' 'opfile
echo ' '' '' '' 'integer' '::' 'ioerror
echo 
echo ' '' '' '' 'write"("rp,format")"' 'anneal
echo 
echo ' '' '' '' 'simfile' '=' 'trim"("simtitle")"' '//' 'trim"("simid")"' '//' 'trim"("rp")"' '//' '\'.txt\'
echo ' '' '' '' 'open' '"("unit' '=' 'simiounit,' 'file' '=' 'trim"("simfile")",' 'status' '=' '\'REPLACE\'")"
echo ' '' '' '' 'write"("simiounit,'*'")"' '\'' '\'
echo ' '' '' '' 'write"("simiounit,'*'")"' '\''*''*''*'' 'Canonical' '2x2' 'Polarized' 'Square' 'Code' ''*''*''*'\'
echo ' '' '' '' 'write"("simiounit,'*'")"' '\'' '\'
echo ' '' '' '' 'write"("simiounit,\""("\'' '\',I4,\'' '\',I3,\'-mer' 'cubes' 'were' 'generated.\'")"\"")"' 'cube,' 'mer
echo ' '' '' '' 'write"("simiounit,\'"("\"' 'Reduced' 'Density' 'of' 'Squares:' '\",' 'F6.2")"\'")"' 'density
echo ' '' '' '' 'write"("simiounit,\'"("\"' 'Region' 'Length:' '\",F7.3")"\'")"' 'region
echo ' '' '' '' 'write"("simiounit,\'"("\"' 'Area' 'Faction:' '\",F4.3")"\'")"' 'eta
echo ' '' '' '' 'write"("simiounit,\'"("\"' 'Reduced' 'Temperature:' '\",' 'F6.2")"\'")"' 'tempset' '/' 'epsilon1
echo ' '' '' '' 'write"("simiounit,'*'")"' '\'' '\'
echo ' '' '' '' 'write"("simiounit,\'"("\"This' 'simulation' 'employs' 'the' 'cell' 'subdivision' 'efficiency' 'technique\"")"\'")"
echo ' '' '' '' 'write"("simiounit,\'"("\"Actual' 'Cell' 'Length:' '\",' 'F6.2")"\'")"' 'lengthCell
echo ' '' '' '' 'write"("simiounit,\'"("\"Number' 'of' 'Cells:' '\",' 'I4")"\'")"' '"("nCells' ''*''*'' 'ndim")"' '
echo ' '' '' '' 'write"("simiounit,\'"("\"Average' 'Number' 'of' 'circles' 'per' 'Cell\",' 'F6.2")"\'")"' 'mer' ''*'' 'density' ''*'' '"("lengthCell' ''*''*'' 'ndim")"
echo ' '' '' '' 'write"("simiounit,'*'")"' '\'' '\'
echo ' '' '' '' 'write"("simiounit,\'"("\"This' 'simulation' 'employs' 'the' 'cell' 'neighbor' 'list' 'efficiency' 'technique\"")"\'")"
echo ' '' '' '' 'write"("simiounit,\'"("\"Length' 'of' 'Neighbor' 'Shell:' '\",' 'F6.2")"\'")"' 'nbrRadius
echo ' '' '' '' 'write"("simiounit,'*'")"' '\'' '\'
echo 
echo 
echo ' '' '' '' 'coorsphfile' '=' 'trim"("simtitle")"' '//' 'trim"("simid")"' '//' 'trim"("rp")"' '//' '\'_\'' '//' '\'sphmov.xyz\'' '!' 'xyz' 'file' 'containing' 'atomic' 'coordinates' 'for' 'ovito' 'animation
echo ' '' '' '' 'if' '"("moviesph' '==' '1")"' 'open' '"("unit' '=' 'coorsphiounit,' 'file' '=' 'trim"("coorsphfile")",' 'status' '=' '\'REPLACE\'")"
echo 
echo ' '' '' '' 'coorsqufile' '=' 'trim"("simtitle")"' '//' 'trim"("simid")"' '//' 'trim"("rp")"' '//' '\'_\'' '//' '\'squmov.xyz\'' '!' 'xyz' 'file' 'containing' 'atomic' 'coordinates' 'for' 'ovito' 'animation
echo ' '' '' '' 'if' '"("moviesqu' '==' '1")"' 'open' '"("unit' '=' 'coorsquiounit,' 'file' '=' 'trim"("coorsqufile")",' 'status' '=' '\'REPLACE\'")"
echo 
echo ' '' '' '' 'annealfile' '=' 'trim"("simtitle")"' '//' 'trim"("simid")"' '//' 'trim"("rp")"' '//' '\'_anneal.csv\'' '!' 'comma' 'seperated' 'list' 'containing' 'a' 'summary' 'of' 'annealing' 'simulations
echo ' '' '' '' 'open' '"("unit' '=' 'annealiounit,' 'file' '=' 'trim"("annealfile")",' 'status' '=' '\'REPLACE\',' 'iostat' '=' 'ioerror")"
echo ' '' '' '' 'write"("annealiounit,'*'")"' '\'id,' 'set,' 'temp,' 'te,' 'pot,' 'ke,' 'h2ts,' 'h2to,' 'anti,' 'poly2,' 'full,' 'fulls,' 'fullo,' 'poly1aa,' 'poly1abba,' '\''&'
echo ' '' '' '' '' '' '' '' '\'poly1bb,' 'poly1,' 'perc,' 'n_clust,' 'nematic\'
echo 
echo ' '' '' '' 'reportfile' '=' 'trim"("simtitle")"' '//' 'trim' '"("simid")"' '//' 'trim"("rp")"' '//' '\'.csv\'' '!' 'comma' 'seperated' 'list' 'containing' 'time' 'progression' 'of' 'properties' '
echo ' '' '' '' 'open' '"("unit' '=' 'reportiounit,' 'file' '=' 'reportfile,' 'status' '=' '\'REPLACE\'")"
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'canonical' '2x2' 'polarized' 'square' '\'
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' '\'
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'number' 'of' 'cubes' ',' '\',' 'cube' '
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'number' 'of' 'spheres' ',' '\',' 'mols' '
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'xa' ',' '\',' 'xa' '
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'na' ',' '\',' 'na
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'area' 'fraction' ',' '\',' 'eta' '
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'density' ',' '\',' 'density' '
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'temp' 'set' 'point' ',' '\',' 'tempfinal
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' '\'
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'hard' 'sphere' 'at' ',' '\',' 'sigma1' '
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'well' '1' 'depth' ',' '\',' 'epsilon2
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'well' '1' 'length' ',' '\',' 'sigma2
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'well' '2' 'depth' ',' '\',' 'epsilon3
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'well' '2' 'length' ',' '\',' 'sigma3
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'delta' ',' '\',' 'delta
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' '\'
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'property' 'calc' 'every,' '\'
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' 'propfreq,' '\'' 'steps' '\'
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' '\'
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'time' ',' 'events' ',' 'te' ',' 'te_fluc' ',' 'ke' ',' 'ke_fluc' ',' 'pot' ',' 'pot_fluc' ',' 'temp' ',' '\','&'
echo ' '' '' '' '\'temp_fluc' ',' 'lm,' 'z' ',' 'collision' 'rate,' 'ghost' ',' ''%'' 'ghost' ',' 'col' 'rate,' 'bonds,' 'hards,' 'wells\'
echo 
echo 
echo ' '' '' '' 'opfile' '=' 'trim"("simtitle")"' '//' 'trim"("simid")"' '//' 'trim"("rp")"' '//' '\'_op.csv\'' '!' 'comma' 'seperated' 'list' 'containing' 'time' 'progression' 'of' 'order' 'parameters
echo ' '' '' '' 'open"("unit' '=' 'opiounit,' 'file' '=' 'trim"("opfile")",' 'status' '=' '\'REPLACE\'")"
echo ' '' '' '' 'write"("opiounit,' ''*'")"' '\'time,' 'events,' 'h2ts,' 'h2ts_fluc,' 'h2to,' 'h2to_fluc,' 'anti,' 'anti_fluc,\',' ''&'
echo ' '' '' '' '' '' '' '' '\'' 'poly2,' 'poly2_fluc,' 'full,' 'full_fluc,' 'fulls,' 'fulls_fluc,' ',fullo,' 'fullo_fluc,' 'poly1aa,' 'poly1aa_fluc,\',' ''&'
echo ' '' '' '' '' '' '' '' '\'' 'poly1abba,' 'poly1abba_fluc,' 'poly1bb,' 'poly1bb_fluc,' 'poly1,' 'poly1_fluc,' 'percolation,' 'nclust,\''&'
echo ' '' '' '' '' '' '' '' '\'' 'nclust_fluc,' 'nematic,' 'nematic_fluc\'
echo end' 'subroutine' 'open_files
echo 
echo subroutine' 'close_files' '"("")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'm' '!' 'indexing' 'parameter
echo 
echo ' '' '' '' '!' 'calculate' 'equilibrium' 'averages
echo ' '' '' '' 'call' 'accumulate_properties' '"("pot,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("ke,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("te,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("temp,' '5")"
echo ' '' '' '' 'do' 'm' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("lm"("m")",' '5")"
echo ' '' '' '' 'end' 'do
echo ' '' '' '' 'call' 'accumulate_properties' '"("z,' '3")"
echo ' '' '' '' '!' 'order' 'parameters' '
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1aa,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1abba,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1bb,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("h2ts,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("h2to,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("anti,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly2,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("full,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("fulls,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("fullo,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("percy,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("nclust,' '5")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("nematic,' '5")"
echo 
echo ' '' '' '' '!' 'report' 'information' 'and' 'close' 'files
echo ' '' '' '' 'write"("simiounit,'*'")"' '\''*''*''*'' 'End' 'of' 'Molecular' 'Simulation' ''*''*''*'\'
echo ' '' '' '' 'write"("simiounit,'*'")"' '\''*''*''*'' 'Canonical' '2x2' 'Polarized' 'Square' 'Code' 'Results' ''*''*''*'\'
echo ' '' '' '' 'write"("simiounit,'*'")"' '\'' '\'
echo ' '' '' '' 'write"("simiounit,\'"("\"Simulation' 'Length' '"("reduced' 'seconds")":' '\",' 'F8.2")"\'")"' 'timenow
echo ' '' '' '' 'write"("simiounit,\'"("\"Number' 'of' 'Events:' '\",' 'F5.1,\"' 'million\"")"\'")"' 'real"("n_events")"/1e6
echo ' '' '' '' 'write"("simiounit,\'"("\"Number' 'of' 'Collisions:' '\",' 'F5.1,\"' 'million' '"("' '\",F5.1,\"' ''%'")"\"")"\'")"' ''&'
echo ' '' '' '' '' '' '' '' 'real"("n_col")"/1e6,' 'real"("n_col")"'*'100/real"("n_events")"
echo ' '' '' '' 'write"("simiounit,\'"("\"Number' 'of' 'Hard' 'Sphere' 'Collisions:' '\",' 'F5.1,\"' 'million' '"("' '\",F5.1,\"' ''%'")"\"")"\'")"' ''&'
echo ' '' '' '' '' '' '' '' 'real"("n_hard")"/1e6,' 'real"("n_hard")"'*'100/real"("n_events")"
echo ' '' '' '' 'write"("simiounit,\'"("\"Number' 'of' 'Well' 'Collisions:' '\",' 'F5.1,\"' 'million' '"("' '\",F5.1,\"' ''%'")"\"")"\'")"' ''&'
echo ' '' '' '' '' '' '' '' 'real"("n_well")"/1e6,' 'real"("n_well")"'*'100/real"("n_events")"
echo ' '' '' '' 'write"("simiounit,\'"("\"Number' 'of' 'Bond' 'Collisions:' '\",' 'F5.1,\"' 'million' '"("' '\",F5.1,\"' ''%'")"\"")"\'")"' ''&'
echo ' '' '' '' '' '' '' '' 'real"("n_bond")"/1e6,' 'real"("n_bond")"'*'100/real"("n_events")"
echo ' '' '' '' 'write"("simiounit,\'"("\"Number' 'of' 'Ghost' 'Collisions:' '\",' 'F5.1,\"' 'million' '"("' '\",F5.1,\"' ''%'")"\"")"\'")"' ''&'
echo ' '' '' '' '' '' '' '' 'real"("n_ghost")"/1e6,' 'real"("n_ghost")"'*'100/real"("n_events")"
echo ' '' '' '' 'write"("simiounit,\'"("\"Ghost' 'Collision' 'Frequency' '"("per' 'second")":' '\",' 'F10.3")"\'")"' 'real"("n_ghost")"' '/' 'timenow
echo ' '' '' '' 'write"("simiounit,'*'")"' '\'' '\'' '
echo ' '' '' '' 'write"("simiounit,\'"("\"Number' 'of' 'Cubes:\",' 'I7")"\'")"' 'cube
echo ' '' '' '' 'write"("simiounit,\'"("\"Reduced' 'Area:' '\",' 'F8.2")"\'")"' 'area
echo ' '' '' '' 'write"("simiounit,\'"("\"Area' 'Faction:' '0\",F4.3")"\'")"' 'eta
echo ' '' '' '' 'write"("simiounit,\'"("\"Reduced' 'Temperature:' '\",F6.3")"\'")"' 'temp'%'equilibrium' '/' 'epsilon1
echo ' '' '' '' 'write"("simiounit,\'"("\"Reduced' 'Pressure:' '\",F6.3")"\'")"' 'z'%'sum' ''*'' 'temp'%'equilibrium' ''*'' 'density' '/' 'epsilon1
echo ' '' '' '' 'write"("simiounit,\'"("\"Linear' 'Momentum' '"("x,' 'y")":' '"("\",F6.3,\",\",F6.3,\"")".\"")"\'")"' 'lm"("1")"'%'equilibrium,' 'lm"("2")"'%'equilibrium
echo ' '' '' '' 'write"("simiounit,\'"("\"' '\"")"\'")"' '
echo ' '' '' '' 'write"("simiounit,\'"("\"Total' 'Energy' '"("per' 'cube")":' '\",' 'F6.3")"\'")"' 'te'%'equilibrium
echo ' '' '' '' 'write"("simiounit,\'"("\"Kinetic' 'Energy' '"("per' 'cube")":' '\",' 'F6.3")"\'")"' 'ke'%'equilibrium
echo ' '' '' '' 'write"("simiounit,\'"("\"Potential' 'Energy' '"("per' 'cube")":' '\",' 'F6.3")"\'")"' 'pot'%'equilibrium
echo ' '' '' '' 'write"("simiounit,\'"("\"' '\"")"\'")"' '
echo ' '' '' '' 'write"("simiounit,\'"("\"Reduced' 'Density' 'of' 'Squares:' '\",' 'F6.3")"\'")"' 'density
echo ' '' '' '' 'write"("simiounit,\'"("\"Beta' 'Epsilon:' '\",' 'F6.3")"\'")"' 'epsilon1' '/' 'temp'%'equilibrium
echo ' '' '' '' 'write"("simiounit,\'"("\"Compressability' 'Factor:' '\",' 'F6.3")"\'")"' 'z'%'sum
echo ' '' '' '' 'write"("simiounit,\'"("\"Reduced' 'Potential' 'Energy' '"("per' 'cube")":' '\",' 'F6.3")"\'")"' 'pot'%'equilibrium' '/' 'epsilon1
echo 
echo ' '' '' '' 'close' '"("unit' '=' 'simiounit,' 'status' '=' '\'KEEP\'")"
echo ' '' '' '' 'if' '"("moviesph' '==' '1")"' 'close' '"("unit' '=' 'coorsphiounit,' 'status' '=' '\'KEEP\'")"
echo ' '' '' '' 'if' '"("moviesqu' '==' '1")"' 'close' '"("unit' '=' 'coorsquiounit,' 'status' '=' '\'KEEP\'")"
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' '\'
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'after' '\'
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'seconds' ',' '\',' 'timenow
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'events' ',' '\',' 'n_events
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'collisions' ',' '' '\',' 'n_col' '
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'ghosts' ',' '\',' 'n_ghost
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'bonds' ',' '\',' 'n_bond
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'hards' ',' '\',' 'n_hard
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'wells' ',' '\',' 'n_well
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' '\'
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'red' 'set' 'point' ',' '\',' 'tempfinal
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'red' 'temperature' ',' '\',' 'temp'%'equilibrium' '/' 'epsilon1
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' ''%'' 'error' ',' '\',' '100' ''*'' '"("tempfinal' '-' '"("temp'%'equilibrium' '/' 'epsilon1")"")"' '/' 'tempfinal
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' '\'
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'ghost' 'per' 'second' ',' '\',' '"("real"("n_ghost")"")"' '/' 'timenow
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' '\'
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'red' 'tote' 'per' 'cube' ',' '\',' '"("te'%'equilibrium' '/' 'epsilon1")"
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'red' 'kene' 'per' 'cube' ',' '\',' '"("ke'%'equilibrium' '/' 'epsilon1")"
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' '\'' 'red' 'pote' 'per' 'cube' '' ',' '\',' '"("pot'%'equilibrium' '/' 'epsilon1")"
echo ' '' '' '' 'close' '"("unit' '=' 'reportiounit,' 'status' '=' '\'KEEP\'")"
echo ' '' '' '' 'close' '"("unit' '=' 'opiounit,' 'status' '=' '\'KEEP\'")"
echo ' '' '' '' 'write"("annealiounit,' ''*'")"' 'anneal,' '\',\',' 'tempset,' '\',\',' 'temp'%'equilibrium,' '\',\',' 'te'%'equilibrium,' '\',\',' 'pot'%'equilibrium,' '\',\',' ''&'
echo ' '' '' '' '' '' '' '' 'ke'%'equilibrium,' '\',\',' 'h2ts'%'equilibrium,' '\',\',' 'h2to'%'equilibrium,\',\',' 'anti'%'equilibrium,' '\',\',' 'poly2'%'equilibrium' ',' ''&'
echo ' '' '' '' '' '' '' '' '\',\',' 'full'%'equilibrium,' '\',\',' 'fulls'%'equilibrium,' '\',\',' 'fullo'%'equilibrium,' '\',\',' 'poly1aa'%'equilibrium,' '\',\','&'
echo ' '' '' '' '' '' '' '' 'poly1abba'%'equilibrium,' '\',\',' 'poly1bb'%'equilibrium,' '\',\',' 'poly1'%'equilibrium,' '\',\',' 'percy'%'equilibrium,' '\',\',' ''&'
echo ' '' '' '' '' '' '' '' 'nclust'%'equilibrium,' '\',\',' 'nematic'%'equilibrium
echo ' '' '' '' 'close' '"("unit' '=' 'annealiounit,' 'status' '=' '\'KEEP\'")"
echo end' 'subroutine' 'close_files
echo 
echo subroutine' 'record_position_circles' '"("")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("position")"' '::' 'ri
echo ' '' '' '' 'character"("len=15")",' 'parameter' '::' 'positive' '=' 'blue
echo ' '' '' '' 'character"("len=15")",' 'parameter' '::' 'negative' '=' 'red' '
echo ' '' '' '' 'character"("len=15")",' 'parameter' '::' 'neutral' '=' 'white' '
echo ' '' '' '' 'character"("len=15")",' 'parameter' '::' 'A' '=' 'green
echo ' '' '' '' 'character"("len=15")",' 'parameter' '::' 'B' '=' 'orange
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'q' '!' 'indexing' 'parameters
echo ' '' '' '' 'character"("len=20")"' '::' 'format,' 'string,' 'charge,' 'type' '
echo 
echo ' '' '' '' 'format' '=' '\""("2"("\'' '\',' 'F7.3")"")"\"
echo 
echo ' '' '' '' 'write"("coorsphiounit,'*'")"' 'mols' '
echo ' '' '' '' 'write"("coorsphiounit,'*'")"' '\'' 'x,' 'y,' 'polcolor' '"("3")",' 'chiralcolor' '"("3")"' '\'' '!' 'comment' 'line' 'frame' 'number' 'starting' 'from' '1
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'real' 'position' 'of' 'the' 'particle
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'ri'%'r"("q")"' '=' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("q")"' '+' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"' ''*'' 'tsl
echo ' '' '' '' '' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'format' 'the' 'position
echo ' '' '' '' '' '' '' '' '' '' '' '' 'write"("string,' 'format")"' 'ri'%'r"("1")",' 'ri'%'r"("2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'determine' 'the' 'chairality' 'of' 'the' 'sphere' '' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'determine' 'the' 'polarization' 'of' 'the' 'sphere' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'select' 'case' '"("square"("i")"'%'circle"("m")"'%'pol")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'case' '"("-1")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'charge' '=' 'negative
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'select' 'case' '"("square"("i")"'%'chai")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'case' '"("1")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'type' '=' 'A' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'case' '"("2")"' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'type' '=' 'B
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'case' 'default
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'type' '=' 'white
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'select' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'case' '"("1")"' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'charge' '=' 'positive
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'select' 'case' '"("square"("i")"'%'chai")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'case' '"("1")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'type' '=' 'A' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'case' '"("2")"' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'type' '=' 'B
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'case' 'default
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'type' '=' 'white
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'select' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'case' 'default' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'charge' '=' 'neutral
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'type' '=' 'white
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'select' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'write' 'the' 'description' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("coorsphiounit,' ''*'")"' 'trim"("string")",' 'trim"("charge")",' 'trim"("type")"
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' 'end' 'do' '
echo end' 'subroutine' 'record_position_circles
echo 
echo subroutine' 'record_position_squares' '"("")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("position")",' 'dimension"("mer")"' '::' 'rcircles' '!' 'position' 'of' 'the' 'group' 'of' 'particles' 'making' 'up' 'the' 'square
echo ' '' '' '' 'type"("position")"' '::' 'rsquare,' 'dr' '!' 'position' 'of' 'the' 'square
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'phi' '!' 'angle' 'of' 'the' 'particle' 'relative' 'to' 'the' 'x-axis
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'x,' 'y,' 'z,' 'w,' 't' '!' 'components' 'of' 'a' 'quaternion
echo ' '' '' '' 'real"("kind=dbl")",' 'dimension"("3,3")"' '::' 'rotate' '!' 'rotation' 'matrix
echo ' '' '' '' 'character"("len=15")",' 'parameter' '::' 'positive' '=' 'blue
echo ' '' '' '' 'character"("len=15")",' 'parameter' '::' 'negative' '=' 'red' '
echo ' '' '' '' 'character"("len=15")",' 'parameter' '::' 'neutral' '=' 'white' '
echo ' '' '' '' 'character"("len=15")",' 'parameter' '::' 'A' '=' 'green
echo ' '' '' '' 'character"("len=15")",' 'parameter' '::' 'B' '=' 'orange
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'q' '!' 'indexing' 'parameters
echo ' '' '' '' 'character"("len=20")"' '::' 'num,' 'format,' 'string,' 'charge,' 'typenum,' 'typecol,' 'qxy,' 'qzw
echo 
echo ' '' '' '' 'format' '=' '\""("2"("\'' '\',' 'F7.3")"")"\"
echo 
echo ' '' '' '' 'write"("coorsquiounit,'*'")"' 'cube
echo ' '' '' '' 'write"("coorsquiounit,'*'")"' '\'' 'position' '"("xy")",' 'orientation' '"("xyzw")",' 'particle' 'type,' 'chiralcolor' '"("RBG")"' '\'' '!' 'comment' 'line' 'frame' 'number' 'starting' 'from' '1
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'real' 'position' 'of' 'all' 'circles
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'real' 'position' 'of' 'the' 'first' 'circle
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'rcircles"("m")"'%'r"("q")"' '=' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("q")"' '+' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"' ''*'' 'tsl
echo ' '' '' '' '' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '' '' '' '' 'call' 'apply_periodic_boundaries' '"("rcircles"("m")"")"
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'orientation' 'of' 'the' 'particle' 'relative' 'to' 'the' 'x-axis' 'by' 'determining' 'its' 'quaternion
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'angle' 'of' 'the' 'particle' 'relative' 'to' 'the' 'x-axis
echo ' '' '' '' '' '' '' '' 'phi' '=' '0.
echo ' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'dr'%'r"("q")"' '=' 'rcircles"("1")"'%'r"("q")"' '-' 'rcircles"("2")"'%'r"("q")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("dr'%'r"("q")"' ''>'=' '0.5'*'region")"' 'dr'%'r"("q")"' '=' 'dr'%'r"("q")"' '-' 'region' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("dr'%'r"("q")"' ''<'' '-0.5'*'region")"' 'dr'%'r"("q")"' '=' 'dr'%'r"("q")"' '+' 'region
echo ' '' '' '' '' '' '' '' '' '' '' '' 'phi' '=' 'phi' '+' '"("dr'%'r"("q")"' ''*''*'' '2")"
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' 'phi' '=' 'sqrt"("phi")"' '
echo ' '' '' '' '' '' '' '' 'phi' '=' '"("dr'%'r"("1")"")"' '/' 'phi' '
echo ' '' '' '' '' '' '' '' 'phi' '=' 'acos"("phi")"' '!' 'bounds' '[-1,' '1],' 'range' '[0,' 'pi]' '
echo ' '' '' '' '' '' '' '' 'if' '"("dr'%'r"("2")"' ''<'' '0")"' 'phi' '=' '-phi
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'rotation' 'matrix' 'of' 'the' 'square' 'using' 'angle
echo ' '' '' '' '' '' '' '' 'rotate"("1,1")"' '=' 'cos"("phi")"
echo ' '' '' '' '' '' '' '' 'rotate"("1,2")"' '=' 'sin"("phi")"
echo ' '' '' '' '' '' '' '' 'rotate"("1,3")"' '=' '0.
echo ' '' '' '' '' '' '' '' 'rotate"("2,1")"' '=' '-sin"("phi")"
echo ' '' '' '' '' '' '' '' 'rotate"("2,2")"' '=' 'cos"("phi")"
echo ' '' '' '' '' '' '' '' 'rotate"("2,3")"' '=' '0.
echo ' '' '' '' '' '' '' '' 'rotate"("3,1")"' '=' '0.' '
echo ' '' '' '' '' '' '' '' 'rotate"("3,2")"' '=' '0.
echo ' '' '' '' '' '' '' '' 'rotate"("3,3")"' '=' '1.
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'quaternion' 'using' 'the' 'rotation' 'matrix
echo ' '' '' '' '' '' '' '' 'x' '=' '0.
echo ' '' '' '' '' '' '' '' 'y' '=' '0.
echo ' '' '' '' '' '' '' '' 'z' '=' '0.
echo ' '' '' '' '' '' '' '' 'w' '=' '0.' '
echo ' '' '' '' '' '' '' '' 'if' '"("rotate"("3,3")"' ''<'' '0.")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'won\'t' 'occur
echo ' '' '' '' '' '' '' '' 'else
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("rotate"("1,1")"' ''<'' '-rotate"("2,2")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 't' '=' '1' '-' 'rotate"("1,1")"' '-' 'rotate"("2,2")"' '+' 'rotate"("3,3")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'x' '=' 'rotate"("3,1")"' '+' 'rotate"("1,3")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'y' '=' 'rotate"("2,3")"' '+' 'rotate"("3,2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'z' '=' 't
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'w' '=' 'rotate"("1,2")"' '-' 'rotate"("2,1")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 't' '=' '1' '+' 'rotate"("1,1")"' '+' 'rotate"("2,2")"' '+' 'rotate"("3,3")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'x' '=' 'rotate"("2,3")"' '-' 'rotate"("3,2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'y' '=' 'rotate"("3,1")"' '-' 'rotate"("1,3")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'z' '=' 'rotate"("1,2")"' '-' 'rotate"("2,1")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'w' '=' 't
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 't' '=' '0.5' '/' 'sqrt"("t")"
echo ' '' '' '' '' '' '' '' 'x' '=' 't' ''*'' 'x' '
echo ' '' '' '' '' '' '' '' 'y' '=' 't' ''*'' 'y' '
echo ' '' '' '' '' '' '' '' 'z' '=' 't' ''*'' 'z' '
echo ' '' '' '' '' '' '' '' 'w' '=' 't' ''*'' 'w' '
echo ' '' '' '' '' '' '' '' '!' 'record' 'the' 'quaternion' '
echo ' '' '' '' '' '' '' '' 'write"("qxy,' 'format")"' 'x,' 'y' '
echo ' '' '' '' '' '' '' '' 'write"("qzw,' 'format")"' 'z,' 'w' '
echo 
echo ' '' '' '' '' '' '' '' '!' 'determine' 'the' 'color' 'of' 'the' 'square
echo ' '' '' '' '' '' '' '' 'write' '"("num,' '\'"("\"' '\",' 'I4")"\'")"' 'i' '
echo ' '' '' '' '' '' '' '' 'write' '"("typenum,' '\'"("\"' '\",' 'I4")"\'")"' 'square"("i")"'%'chai
echo ' '' '' '' '' '' '' '' 'select' 'case' '"("square"("i")"'%'chai")"
echo ' '' '' '' '' '' '' '' 'case' '"("1")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'typecol' '=' 'A' '
echo ' '' '' '' '' '' '' '' 'case' '"("2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'typecol' '=' 'B' '
echo ' '' '' '' '' '' '' '' 'case' 'default' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'typecol' '=' 'white' '
echo ' '' '' '' '' '' '' '' 'end' 'select' '
echo 
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'center' 'of' 'the' 'square' 'particle' 'based' 'on' 'the' 'position' 'of' 'the' 'first' 'particle
echo ' '' '' '' '' '' '' '' 'rsquare'%'r"("1")"' '=' 'rcircles"("1")"'%'r"("1")"' '+' '"("sqrt"("2.")"' '/' '2.")"' ''*'' 'cos"(""("5.' ''*'' 'pi' '/' '4.")"' '+' 'phi")"
echo ' '' '' '' '' '' '' '' 'rsquare'%'r"("2")"' '=' 'rcircles"("1")"'%'r"("2")"' '+' '"("sqrt"("2.")"' '/' '2.")"' ''*'' 'sin"(""("5.' ''*'' 'pi' '/' '4.")"' '+' 'phi")"
echo ' '' '' '' '' '' '' '' '!' 'apply' 'preiodic' 'boundary' 'conditions
echo ' '' '' '' '' '' '' '' 'call' 'apply_periodic_boundaries' '"("rsquare")"
echo ' '' '' '' '' '' '' '' 'write"("string,' 'format")"' 'rsquare'%'r"("1")",' 'rsquare'%'r"("2")"
echo 
echo ' '' '' '' '' '' '' '' '!' 'report' 'the' 'description
echo ' '' '' '' '' '' '' '' 'write"("coorsquiounit,' ''*'")"' 'trim"("num")",' 'trim"("string")",' 'trim"("qxy")",' 'trim"("qzw")",' 'trim"("typenum")",' 'trim"("typecol")"
echo ' '' '' '' 'end' 'do' '
echo end' 'subroutine' 'record_position_squares
echo 
echo subroutine' 'report_properties"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'q' '
echo 
echo ' '' '' '' '!' 'average' 'properties
echo ' '' '' '' 'do' 'q' '=' '1,' 'ndim
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("lm"("q")",' '3")"' '!' 'calculate' 'the' 'average' 'linear' 'momentum
echo ' '' '' '' 'end' 'do
echo ' '' '' '' 'call' 'accumulate_properties' '"("te,' '3")"' '!' 'calculate' 'the' 'average' 'total' 'energy' '
echo ' '' '' '' 'call' 'accumulate_properties' '"("pot,' '3")"' '!' 'calculate' 'the' 'average' 'potential' 'energy
echo ' '' '' '' 'call' 'accumulate_properties' '"("ke,' '3")"' '!' 'calculate' 'the' 'average' 'kinetic' 'energy' '
echo ' '' '' '' 'call' 'accumulate_properties' '"("temp,' '3")"' '!' 'calculate' 'the' 'average' 'temperature' '
echo ' '' '' '' 'call' 'accumulate_properties' '"("h2ts,' '3")"' '!' 'calculate' 'the' 'average' 'head-to-tail-same' 'order' 'parameter' 'value' '
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1,' '3")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1aa,' '3")"' '!' 'calculate' 'the' 'average' 'aa' 'polymerization
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1abba,' '3")"' '!' 'calculate' 'the' 'average' 'ab-ba' 'polymerization
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1bb,' '3")"' '!' 'calculate' 'the' 'average' 'bb' 'polymerization
echo ' '' '' '' 'call' 'accumulate_properties' '"("h2ts,' '3")"' '!' 'calculate' 'the' 'average' 'head-to-tail-same' 'order' 'parameter' 'value
echo ' '' '' '' 'call' 'accumulate_properties' '"("h2to,' '3")"' '!' 'calculate' 'the' 'average' 'head-to-tail-opposite' 'order' 'parameter' 'value
echo ' '' '' '' 'call' 'accumulate_properties' '"("anti,' '3")"' '!' 'calculate' 'the' 'average' 'antiparallel' 'order' 'parameter' 'value' '
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly2,' '3")"' '!' 'calculate' 'the' 'average' 'polymerization' 'order' 'parameter' 'value' '
echo ' '' '' '' 'call' 'accumulate_properties' '"("full,' '3")"' '!' 'calculate' 'the' 'average' 'fully-assembled' 'order' 'parameter' 'value
echo ' '' '' '' 'call' 'accumulate_properties' '"("fulls,' '3")"' '!' 'calculate' 'the' 'average' 'fully-assembled-same' 'order' 'parameter' 'value
echo ' '' '' '' 'call' 'accumulate_properties' '"("fullo,' '3")"' '!' 'calculate' 'the' 'average' 'fully-assembled-oppo' 'order' 'parameter' 'value
echo ' '' '' '' 'call' 'accumulate_properties' '"("percy,' '3")"' '!' 'calculate' 'the' 'average' 'percolation' 'order' 'parameter' 'value
echo ' '' '' '' 'call' 'accumulate_properties' '"("nclust,' '3")"' '!' 'calculate' 'the' 'average' 'number' 'of' 'clusters
echo ' '' '' '' 'call' 'accumulate_properties' '"("nematic,' '3")"' '!' 'calculate' 'the' 'average' 'nematic' 'order' 'parameter' '
echo ' '' '' '' 'z'%'value' '=' '"("pv'%'sum' '/' '"("2.' ''*'' 'real"("cube")"' ''*'' 'timeperiod' ''*'' 'temp'%'sum")"")"' '+' 'real"("mer")"' '!' 'calculate' 'compressability' 'factor,' 'equation' '8' 'in' 'Erpenbeck' 'et' 'al.
echo 
echo ' '' '' '' '!' 'report' 'values' 'to' 'the' 'user' '
echo ' '' '' '' 'write"("simiounit,\""("\'' '\',F7.2,\'' '\',I10,\'' '\',6"("\'' '' '' '\',F6.3")"")"\"")"' 'timenow,' 'n_events,' 'te'%'sum,'&'
echo ' '' '' '' '' '' '' '' 'pot'%'sum,' 'ke'%'sum,' 'temp'%'sum,' 'lm"("1")"'%'sum+lm"("2")"'%'sum,' 'z'%'value
echo ' '' '' '' 'write"("reportiounit,' ''*'")"' 'timenow,' '\',\',' 'n_events,' '\',\',' 'te'%'sum,' '\',\',' 'te'%'sum2,' '\',\',' 'ke'%'sum,\',\',' ''&'
echo ' '' '' '' '' '' '' '' 'ke'%'sum2,' '\',\',' 'pot'%'sum,' '\',\',' 'pot'%'sum2,' '\',\',' 'temp'%'sum,' '\',\',' 'temp'%'sum2,' '\',\',' '"("lm"("1")"'%'sum+lm"("2")"'%'sum")",' ''&'
echo ' '' '' '' '' '' '' '' '\',\',' 'z'%'value,' '\',\',' 'n_col,' '\',\',' 'n_ghost,' '\',\',' '"("n_ghost' '/' 'n_events")",' '\',\',' '"("n_col' '/' 'timenow")",' '\',\',' ''&'
echo ' '' '' '' '' '' '' '' 'n_bond,' '\',\',' 'n_hard,' '\',\',' 'n_well
echo ' '' '' '' 'write"("opiounit,' ''*'")"' 'timenow,' '\',\',' 'n_events,' '\',\',' 'h2ts'%'sum,' '\',\',' 'h2ts'%'sum2,' '\',\',' 'h2to'%'sum,' '\',\',' 'h2to'%'sum2,' ''&'
echo ' '' '' '' '' '' '' '' '\',\',' 'anti'%'sum,\',\',' '\',\',' 'anti'%'sum2,' '\',\',' 'poly2'%'sum,' '\',\',' 'poly2'%'sum2,' '\',\',' 'full'%'sum,' '\',\',' 'full'%'sum2,' ''&'
echo ' '' '' '' '' '' '' '' '\',\',' 'fulls'%'sum,' '\',\',' 'fulls'%'sum2,' '\',\',' 'fullo'%'sum,' '\',\',' 'fullo'%'sum2,' '\',\',' 'poly1aa'%'sum,' '\',\',' 'poly1aa'%'sum2,' ''&'
echo ' '' '' '' '' '' '' '' '\',\',' 'poly1abba'%'sum,' '\',\',' 'poly1abba'%'sum2,' '\',\',' 'poly1bb'%'sum,' '\',\',' 'poly1bb'%'sum2,' '\',\',' ''&'
echo ' '' '' '' '' '' '' '' 'poly1'%'sum,\',\',' 'poly1'%'sum2,' '\',\',' 'percy'%'sum,' '\',\',' 'nclust'%'sum,' '\',\',' 'nclust'%'sum2,' '\',\',' 'nematic'%'sum,' ''&'
echo ' '' '' '' '' '' '' '' '\',\',' 'nematic'%'sum2
echo 
echo ' '' '' '' '!' 'if' 'the' 'system' 'has' 'equilibraited,' 'accumulate' 'equilibrium' 'sums
echo ' '' '' '' 'if' '"("n_events' ''>'' 'event_equilibriate")"' 'then' '
echo ' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim
echo ' '' '' '' '' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("lm"("q")",' '4")"
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("te,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("pot,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("ke,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("temp,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("poly1,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("poly1aa,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("poly1abba,' '4")"' '
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("poly1bb,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("h2ts,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("h2to,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("anti,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("poly2,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("full,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("fulls,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("fullo,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("percy,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("nclust,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("nematic,' '4")"
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("z,' '2")"
echo ' '' '' '' 'end' 'if' '
echo 
echo ' '' '' '' '!' 'reset' 'property' 'accumulation
echo ' '' '' '' 'do' 'q' '=' '1,' 'ndim
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("lm"("q")",' '1")"
echo ' '' '' '' 'end' 'do
echo ' '' '' '' 'call' 'accumulate_properties' '"("te,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("pot,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("ke,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("temp,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("pv,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1aa,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1abba,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1bb,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("h2ts,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("h2to,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("anti,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly2,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("full,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("fulls,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("fullo,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("percy,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("nclust,' '1")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("nematic,' '1")"
echo ' '' '' '' 'timeperiod' '=' '0.
echo end' 'subroutine' 'report_properties
echo 
echo 
echo !' ''*''*'' 'propertty' 'methods' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo subroutine' 'initialize_properties' '"("")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'm
echo 
echo ' '' '' '' 'call' 'accumulate_properties' '"("te,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("ke,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("pot,' '0")"
echo ' '' '' '' 'do' 'm' '=' '1,' 'ndim
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("lm"("m")",' '0")"
echo ' '' '' '' 'end' 'do
echo ' '' '' '' 'call' 'accumulate_properties' '"("temp,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("pv,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("z,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1aa,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1abba,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1bb,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("h2ts,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("h2to,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("anti,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly2,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("full,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("fulls,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("fullo,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("percy,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("nclust,' '0")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("nematic,' '0")"
echo end' 'subroutine' 'initialize_properties
echo 
echo subroutine' 'calculate_poperties"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("velocity")"' '::' 'vsum' '
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'vvsum' '
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'q' '
echo 
echo ' '' '' '' '!' 'initialize' 'parameters' '
echo ' '' '' '' 'vvsum' '=' '0.
echo ' '' '' '' 'do' 'q' '=' '1,' 'ndim
echo ' '' '' '' '' '' '' '' 'vsum'%'v"("q")"' '=' '0.
echo ' '' '' '' 'end' 'do' '
echo 
echo ' '' '' '' '!' 'sum' 'velocities' '
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube' '
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'vsum'%'v"("q")"' '=' 'vsum'%'v"("q")"' '+' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'vvsum' '=' 'vvsum' '+' '"("square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"' ''*''*'' '2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'enddo' '
echo ' '' '' '' '' '' '' '' 'enddo' '
echo ' '' '' '' 'enddo
echo 
echo ' '' '' '' '!' ''*''*'' 'Linear' 'Momentum' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'do' 'q' '=' '1,' 'ndim
echo ' '' '' '' '' '' '' '' 'lm"("q")"'%'value' '=' '"("vsum'%'v"("q")"")"' '/' 'real"("cube")"' '!' 'linear' 'momentum' 'per' 'cube' '
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("lm"("q")",' '2")"
echo ' '' '' '' 'end' 'do
echo ' '' '' '' '!' ''*''*'' 'Potential' 'Energy' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'call' 'accumulate_potential' '"("pot'%'value")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("pot,' '2")"
echo ' '' '' '' '!' ''*''*'' 'Kinetic' 'Energy' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'ke'%'value' '=' '"("0.5' ''*'' 'vvsum' '/' '"("real"("cube")"' ''*'' 'real"("mer")"")"")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("ke,' '2")"
echo ' '' '' '' '!' ''*''*'' 'Total' 'Energy' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'te'%'value' '=' 'ke'%'value' '+' 'pot'%'value' '
echo ' '' '' '' 'call' 'accumulate_properties' '"("te,' '2")"
echo ' '' '' '' '!' ''*''*'' 'Temperature' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'temp'%'value' '=' '2.' ''*'' 'ke'%'value' '/' '"("real"("ndim")"")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("temp,' '2")"
echo ' '' '' '' '!' ''*''*'' 'Order' 'Parameters' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'call' 'determine_assembly' '"("poly1'%'value,' 'poly1aa'%'value,' 'poly1abba'%'value,' 'poly1bb'%'value,' 'h2ts'%'value,' ''&'
echo ' '' '' '' '' '' '' '' 'h2to'%'value,' 'anti'%'value,' 'poly2'%'value,' 'full'%'value,' 'fulls'%'value,' 'fullo'%'value")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1,' '2")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1aa,' '2")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1abba,' '2")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly1bb,' '2")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("h2ts,' '2")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("h2to,' '2")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("anti,' '2")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("poly2,' '2")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("full,' '2")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("fulls,' '2")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("fullo,' '2")"
echo ' '' '' '' '!' ''*''*'' 'percolation' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'if' '"("determine_percolation"("nclust'%'value")"")"' 'then' '
echo ' '' '' '' '' '' '' '' 'percy'%'value' '=' '1.
echo ' '' '' '' 'else
echo ' '' '' '' '' '' '' '' 'percy'%'value' '=' '0.
echo ' '' '' '' 'endif
echo ' '' '' '' 'call' 'accumulate_properties' '"("percy,' '2")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("nclust,' '2")"
echo ' '' '' '' '!' ''*''*'' 'nematic' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'call' 'determine_nematic' '"("nematic'%'value")"
echo ' '' '' '' 'call' 'accumulate_properties' '"("nematic,' '2")"
echo end' 'subroutine' 'calculate_poperties
echo 
echo subroutine' 'accumulate_potential' '"("potential")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")",' 'intent"("out")"' '::' 'potential' '!' 'potential' 'accumulation
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'rij
echo ' '' '' '' 'integer' '::' 'i,' 'j,' 'm,' 'n,' 'q,' 'o' '!' 'indexing' 'parameters' '
echo ' '' '' '' '
echo ' '' '' '' '!' 'initialize' 'parameters' '
echo ' '' '' '' 'potential' '' '=' '0.
echo 
echo ' '' '' '' '!' 'loop' 'through' 'all' 'squares' '
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube' '-' '1
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'loop' 'through' 'all' 'up' 'list' 'atoms' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'o' '=' '0' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'uplist:' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'o' '=' 'o' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j' '=' 'square"("i")"'%'circle"("m")"'%'upnab"("o")"'%'one' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("j' '==' '0")"' 'exit' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("i' '/=' 'j")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'n' '=' 'square"("i")"'%'circle"("m")"'%'upnab"("o")"'%'two' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'real' 'distance' 'between' 'the' 'pair
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'rij' '=' 'distance"("square"("i")"'%'circle"("m")",' 'square"("j")"'%'circle"("n")"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("rij' ''<'' 'sigma2")"' 'then' '!' 'if' 'the' 'pair' 'is' 'within' 'the' 'first,' 'innermost' 'well
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"(""("square"("i")"'%'circle"("m")"'%'pol' ''*'' 'square"("j")"'%'circle"("n")"'%'pol")"' '==' '-1")"' 'then' '!' 'if' 'the' 'spheres' 'are' 'attracted' 'to
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'potential' '=' 'potential' '-' 'epsilon2
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'else' 'if' '"(""("square"("i")"'%'circle"("m")"'%'pol' ''*'' 'square"("j")"'%'circle"("n")"'%'pol")"' '==' '1")"' 'then' '!' 'if' 'the' 'spheres' 'are' 'repulsed' 'from' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'potential' '=' 'potential' '+' 'epsilon2
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'else' 'if' '"("rij' ''<'' 'sigma3")"' 'then' '!' 'if' 'the' 'pair' 'is' 'within' 'the' 'second,' 'middle' 'well' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"(""("square"("i")"'%'circle"("m")"'%'pol' ''*'' 'square"("j")"'%'circle"("n")"'%'pol")"' '==' '-1")"' 'then' '!' 'if' 'the' 'spheres' 'are' 'attracted' 'to
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'potential' '=' 'potential' '-' 'epsilon3
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'else' 'if' '"(""("square"("i")"'%'circle"("m")"'%'pol' ''*'' 'square"("j")"'%'circle"("n")"'%'pol")"' '==' '1")"' 'then' '!' 'if' 'the' 'spheres' 'are' 'repulsed' 'from
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'potential' '=' 'potential' '+' 'epsilon3
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' 'enddo' 'uplist
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' 'enddo' '
echo ' '' '' '' 'potential' '=' 'potential' '/' '"("real"("cube")"' ''*'' 'real"("mer")"")"' '!' 'potential' 'energy' 'per' 'sphere
echo end' 'subroutine' 'accumulate_potential
echo 
echo subroutine' 'accumulate_properties' '"("prop,' 'number")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("property")",' 'intent"("inout")"' '::' 'prop
echo ' '' '' '' 'integer,' 'intent"("in")"' '::' 'number
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' 'if' '"("number' '==' '0")"' 'then
echo ' '' '' '' '' '' '' '' 'prop'%'sum' '=' '0.
echo ' '' '' '' '' '' '' '' 'prop'%'sum2' '=' '0.
echo ' '' '' '' '' '' '' '' 'prop'%'equilibrium' '=' '0.
echo ' '' '' '' '' '' '' '' 'prop'%'count' '=' '0
echo ' '' '' '' '' '' '' '' 'prop'%'equilibcount' '=' '0
echo ' '' '' '' 'else' 'if' '"("number' '==' '1")"' 'then' '
echo ' '' '' '' '' '' '' '' 'prop'%'sum' '=' '0.
echo ' '' '' '' '' '' '' '' 'prop'%'sum2' '=' '0.
echo ' '' '' '' '' '' '' '' 'prop'%'count' '=' '0
echo ' '' '' '' 'else' 'if' '"("number' '==' '2")"' 'then
echo ' '' '' '' '' '' '' '' 'prop'%'count' '=' 'prop'%'count' '+' '1
echo ' '' '' '' '' '' '' '' 'prop'%'sum' '=' 'prop'%'sum' '+' 'prop'%'value
echo ' '' '' '' '' '' '' '' 'prop'%'sum2' '=' 'prop'%'sum2' '+' '"("prop'%'value' ''*''*'' '2")"
echo ' '' '' '' 'else' 'if' '"("number' '==' '3")"' 'then
echo ' '' '' '' '' '' '' '' 'prop'%'sum' '=' 'prop'%'sum' '/' 'prop'%'count
echo ' '' '' '' '' '' '' '' 'prop'%'sum2' '=' 'sqrt"("prop'%'sum2' '/' 'prop'%'count' '-' '"("prop'%'sum' ''*''*'' '2")"")"
echo ' '' '' '' 'else' 'if' '"("number' '==' '4")"' 'then
echo ' '' '' '' '' '' '' '' 'prop'%'equilibrium' '=' 'prop'%'equilibrium' '+' 'prop'%'sum' '
echo ' '' '' '' '' '' '' '' 'prop'%'equilibcount' '=' 'prop'%'equilibcount' '+' '1
echo ' '' '' '' 'else' 'if' '"("number' '==' '5")"' 'then' '
echo ' '' '' '' '' '' '' '' 'prop'%'equilibrium' '=' 'prop'%'equilibrium' '/' 'prop'%'equilibcount
echo ' '' '' '' 'else
echo ' '' '' '' '' '' '' '' 'write"("'*','*'")"' '\'Error' 'in' 'execution' 'of' 'accumulate_properties' 'subroutine\'
echo ' '' '' '' 'end' 'if
echo end' 'subroutine' 'accumulate_properties
echo 
echo !' '//' 'assembly' 'order' 'parameters' '//
echo 
echo subroutine' 'set_orderlist"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'rij
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'j,' 'q,' 'o
echo ' '' '' '' 'integer,' 'dimension"("mols")"' '::' 'n
echo ' '' '' '' 'type"("id")"' '::' 'a,' 'b
echo 
echo ' '' '' '' '!' 'set' 'all' 'lists' 'to' 'zero' '
echo ' '' '' '' 'n' '=' '1
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube' '
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'orderlist' '=' 'nullset"("")"
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' 'enddo
echo 
echo ' '' '' '' '!' 'loop' 'through' 'all' 'pairs' 'using' 'upnab' '
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube' '
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'a'%'one' '=' 'i' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'a'%'two' '=' 'm' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'q' '=' '0
echo ' '' '' '' '' '' '' '' '' '' '' '' 'uplist:' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'q' '=' 'q' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'b' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'upnab"("q")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("b'%'one' '==' '0")"' 'exit' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'if' 'the' 'particle' 'pair' 'not' 'in' 'the' 'same' 'group' 'and' 'oppositely' 'charged' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"(""("b'%'one' ''>'' 'a'%'one")"' '.and.' '"("square"("a'%'one")"'%'circle"("a'%'two")"'%'pol' '==' '-square"("b'%'one")"'%'circle"("b'%'two")"'%'pol")"")"' 'then
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'determine' 'the' 'distance' 'between' 'the' 'pair
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'rij' '=' 'distance"("square"("a'%'one")"'%'circle"("a'%'two")",' 'square"("b'%'one")"'%'circle"("b'%'two")"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'if' 'the' 'particle' 'pair' 'is' 'less' 'than' 'the' 'maximum' 'distance' 'of' 'seperation' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("rij' ''<'' 'orderwidth")"' 'then' '!' 'record' 'each' 'pair' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'o' '=' 'id2mol"("a'%'one,' 'a'%'two")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("n"("o")"' ''<'' '"("orderlength' '+' '1")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'orderlist"("n"("o")"")"' '=' 'b
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'n"("o")"' '=' 'n"("o")"' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j' '=' 'id2mol"("b'%'one,' 'b'%'two")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("n"("j")"' ''<'' '"("orderlength' '+' '1")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'orderlist"("n"("j")"")"' '=' 'a' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'n"("j")"' '=' 'n"("j")"' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' 'enddo' 'uplist' '
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' 'enddo
echo end' 'subroutine' 'set_orderlist
echo 
echo subroutine' 'update_orderlist"("a,' 'b")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("id")",' 'intent"("in")"' '::' 'a,' 'b
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'rij
echo ' '' '' '' 'integer' '::' 'n
echo 
echo ' '' '' '' '!' 'if' 'the' 'pair' 'are' 'bound' 'to' 'each' 'other,' 'or' 'not' 'oppositely' 'charged' '
echo ' '' '' '' 'if' '"(""("a'%'one' '==' 'b'%'one")"' '.or.' '"("square"("a'%'one")"'%'circle"("a'%'two")"'%'pol' ''*'' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'pol' '/=' '-1")"")"' 'return
echo 
echo ' '' '' '' '!' 'determine' 'the' 'distance' 'between' 'the' 'pair' '
echo ' '' '' '' 'rij' '=' 'distance"("square"("a'%'one")"'%'circle"("a'%'two")",' 'square"("b'%'one")"'%'circle"("b'%'two")"")"
echo ' '' '' '' 'if' '"("rij' ''<'' 'orderwidth")"' 'then' '!' 'if' 'the' 'pair' 'are' 'within' 'range' 'after' 'the' 'event' 'has' 'occured' '
echo ' '' '' '' '' '' '' '' '!' 'add' 'the' 'pair' 'to' 'each' 'other\'s' 'list,' 'if' 'they' 'are' 'not' 'there' 'already
echo ' '' '' '' '' '' '' '' '!' 'update' 'order' 'list' 'of' 'particle' 'a' '
echo ' '' '' '' '' '' '' '' 'n' '=' '0' '
echo ' '' '' '' '' '' '' '' 'add2a:' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'n' '=' 'n' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("idequiv"("square"("a'%'one")"'%'circle"("a'%'two")"'%'orderlist"("n")",' 'b")"")"' 'exit
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("idequiv"("square"("a'%'one")"'%'circle"("a'%'two")"'%'orderlist"("n")",' 'nullset"("")"")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'orderlist"("n")"' '=' 'b' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'exit' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'enddo' 'add2a
echo ' '' '' '' '' '' '' '' '!' 'update' 'orderlist' 'of' 'particle' 'b
echo ' '' '' '' '' '' '' '' 'n' '=' '0
echo ' '' '' '' '' '' '' '' 'add2b:' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'n' '=' 'n' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("idequiv"("square"("b'%'one")"'%'circle"("b'%'two")"'%'orderlist"("n")",' 'a")"")"' 'exit
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("idequiv"("square"("b'%'one")"'%'circle"("b'%'two")"'%'orderlist"("n")",' 'nullset"("")"")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'orderlist"("n")"' '=' 'a' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'exit' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'enddo' 'add2b
echo ' '' '' '' 'else' '!' 'if' 'the' 'pair' 'are' 'not' 'within' 'range' '
echo ' '' '' '' '' '' '' '' '!' 'remove' 'any' 'occurances' 'of' 'the' 'pair' 'from' 'and' 'then' 'update' 'each' 'other\'s' 'lists
echo ' '' '' '' '' '' '' '' 'do' 'n' '=' '1,' 'orderlength
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'delete' 'the' 'partner,' 'if' 'it' 'is' 'in' 'the' 'list' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("idequiv"("square"("a'%'one")"'%'circle"("a'%'two")"'%'orderlist"("n")",' 'b")"")"' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'orderlist"("n")"' '=' 'nullset"("")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("idequiv"("square"("b'%'one")"'%'circle"("b'%'two")"'%'orderlist"("n")",' 'a")"")"' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'orderlist"("n")"' '=' 'nullset"("")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'if' 'the' 'element' 'is' 'empty,' 'shift' 'the' 'list' 'forward' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("n' '/=' 'orderlength")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("idequiv"("square"("a'%'one")"'%'circle"("a'%'two")"'%'orderlist"("n")",' 'nullset"("")"")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'orderlist"("n")"' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'orderlist"("n' '+' '1")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'orderlist"("n' '+' '1")"' '=' 'nullset"("")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("idequiv"("square"("b'%'one")"'%'circle"("b'%'two")"'%'orderlist"("n")",' 'nullset"("")"")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'orderlist"("n")"' '=' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'orderlist"("n' '+' '1")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'orderlist"("n' '+' '1")"' '=' 'nullset"("")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'enddo' '
echo ' '' '' '' 'endif
echo end' 'subroutine' 'update_orderlist
echo 
echo subroutine' 'determine_assembly' '"("poly1,' 'aa,' 'abba,' 'bb,' 'head2tailsame,' 'head2tailoppo,' 'antiparallel,' 'poly2,' ''&'
echo ' '' '' '' 'fullyassembeled,' 'fullass_s,' 'fullass_o")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")",' 'intent"("out")"' '::' 'poly1,' 'aa,' 'abba,' 'bb,' 'head2tailsame,' 'head2tailoppo,' 'antiparallel,' 'poly2,' ''&'
echo ' '' '' '' 'fullyassembeled,' 'fullass_s,' 'fullass_o
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("id")",' 'dimension"("orderlength")"' '::' 'ipartner,' 'jpartner' '!' 'cube' 'partners' 'of' 'polarized' 'spheres' '
echo ' '' '' '' 'type"("id")"' '::' 'i,' 'j
echo ' '' '' '' 'integer' '::' 'n,' 'm,' 'iindex,' 'jindex,' 'o,' 'p' '!' 'indexing' '
echo ' '' '' '' 'logical' '::' 'samesame,' 'sameoppo,' 'samepartner,' 'diffpartner,' 'diffpartner_oppochai,' 'diffpartner_samechai' '' '!' 'logical' 'values' 'for' 'recording' 'the' 'order
echo 
echo 
echo ' '' '' '' '!' 'initialize' 'values' '
echo ' '' '' '' 'poly1' '=' '0.
echo ' '' '' '' 'aa' '=' '0.
echo ' '' '' '' 'abba' '=' '0.' '
echo ' '' '' '' 'bb' '=' '0.
echo ' '' '' '' 'head2tailsame' '=' '0.
echo ' '' '' '' 'head2tailoppo' '=' '0.
echo ' '' '' '' 'antiparallel' '=' '0.
echo ' '' '' '' 'poly2' '=' '0.
echo ' '' '' '' 'fullyassembeled' '=' '0.
echo ' '' '' '' 'fullass_s' '=' '0.
echo ' '' '' '' 'fullass_o' '=' '0.
echo 
echo ' '' '' '' 'eachcube:' 'do' 'n' '=' '1,' 'cube' '!' 'for' 'each' 'cube' '
echo ' '' '' '' '' '' '' '' 'i'%'one' '=' 'n' '
echo ' '' '' '' '' '' '' '' 'i'%'two' '=' '1' '!' 'first' 'polarized' 'particle' 'is' 'the' 'first' 'sphere
echo ' '' '' '' '' '' '' '' 'j'%'one' '=' 'n' '
echo ' '' '' '' '' '' '' '' 'j'%'two' '=' '2' '!' 'HARD' 'CODE:' 'second' 'polarized' 'particle' 'is' 'the' 'second' 'sphere
echo ' '' '' '' '' '' '' '' 'ipartner' '=' 'nullset"("")"
echo ' '' '' '' '' '' '' '' 'jpartner' '=' 'nullset"("")"
echo ' '' '' '' '' '' '' '' 'iindex' '=' '0
echo ' '' '' '' '' '' '' '' 'jindex' '=' '0
echo ' '' '' '' '' '' '' '' '!' 'record' 'cubic' 'partners' 'of' 'i' '
echo ' '' '' '' '' '' '' '' 'ilist:' 'do' 'm' '=' '1,' 'orderlength' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("idequiv"("square"("i'%'one")"'%'circle"("i'%'two")"'%'orderlist"("m")",' 'nullset"("")"")"")"' 'exit
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'record' 'that' 'partner' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'iindex' '=' 'iindex' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' 'ipartner"("iindex")"' '=' 'square"("i'%'one")"'%'circle"("i'%'two")"'%'orderlist"("m")"' '!' 'partner' 'to' 'polarized' 'particle' 'i' '
echo ' '' '' '' '' '' '' '' 'enddo' 'ilist' '
echo ' '' '' '' '' '' '' '' '!' 'record' 'cubic' 'partners' 'of' 'j' '
echo ' '' '' '' '' '' '' '' 'jlist:' 'do' 'm' '=' '1,' 'orderlength
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("idequiv"("square"("j'%'one")"'%'circle"("j'%'two")"'%'orderlist"("m")",' 'nullset"("")"")"")"' 'exit' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'record' 'that' 'partner' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'jindex' '=' 'jindex' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' 'jpartner"("jindex")"' '=' 'square"("j'%'one")"'%'circle"("j'%'two")"'%'orderlist"("m")"' '!' 'partner' 'to' 'polarized' 'particle' 'j' '
echo ' '' '' '' '' '' '' '' 'enddo' 'jlist' '
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'order' 'of' 'cube' 'n' '
echo ' '' '' '' '' '' '' '' 'samesame' '=' '.false.
echo ' '' '' '' '' '' '' '' 'sameoppo' '=' '.false.
echo ' '' '' '' '' '' '' '' 'samepartner' '=' '.false.
echo ' '' '' '' '' '' '' '' 'diffpartner' '=' '.false.
echo ' '' '' '' '' '' '' '' 'diffpartner_samechai' '=' '.false.
echo ' '' '' '' '' '' '' '' 'diffpartner_oppochai' '=' '.false.
echo ' '' '' '' '' '' '' '' 'if' '"(""("iindex' ''>'=' '1")"' '.or.' '"("jindex' ''>'=' '1")"")"' 'then' '!' 'if' 'the' 'square' 'has' 'at' 'least' 'one' 'partner' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("iindex' ''>'=' '1")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'o' '=' '1,' 'iindex
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("square"("n")"'%'chai' '==' 'square"("ipartner"("o")"'%'one")"'%'chai")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'samesame' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'else
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'sameoppo' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("jindex' ''>'=' '1")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'p' '=' '1,' 'jindex
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("square"("n")"'%'chai' '==' 'square"("jpartner"("p")"'%'one")"'%'chai")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'samesame' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'else
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'sameoppo' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'if' '"(""("iindex' ''>'=' '1")"' '.and.' '"("jindex' ''>'=' '1")"")"' 'then' '!' 'if' 'both' 'polarized' 'particles' 'have' 'cubic' 'partners
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'o' '=' '1,' 'iindex
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'p' '=' '1,' 'jindex' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'if' 'either' 'of' 'the' 'polarized' 'particles' 'share' 'the' 'same' 'cubic' 'partners
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("ipartner"("o")"'%'one' '==' 'jpartner"("p")"'%'one")"' 'samepartner' '=' '.true.' '!' 'NOTE:' 'this' 'formation' 'is' 'only' 'possible' 'for' 'same' 'chirality' 'squares
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'if' 'either' 'of' 'the' 'polarized' 'particles' 'have' 'different' 'cubic' 'partners' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("ipartner"("o")"'%'one' '/=' 'jpartner"("p")"'%'one")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'diffpartner' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'if' 'the' 'two' 'different' 'partners' 'of' 'the' 'first' 'and' 'second' 'polarized' 'spheres' 'share' 'the' 'same' 'chiraility
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("square"("ipartner"("o")"'%'one")"'%'chai' '==' 'square"("jpartner"("p")"'%'one")"'%'chai")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'if' 'the' 'chairality' 'of' 'those' 'partners' 'is' 'the' 'same' 'as' 'the' 'cube' 'n
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("square"("n")"'%'chai' '==' 'square"("ipartner"("o")"'%'one")"'%'chai")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'diffpartner_samechai' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'else' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'diffpartner_oppochai' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'if' '"("samesame' '.or.' 'sameoppo")"' 'poly1' '=' 'poly1' '+' '1.
echo ' '' '' '' '' '' '' '' 'if' '"(""("square"("n")"'%'chai' '==' '1")"' '.and.' 'samesame")"' 'aa' '=' 'aa' '+' '1.
echo ' '' '' '' '' '' '' '' 'if' '"(""("square"("n")"'%'chai' '==' '2")"' '.and.' 'samesame")"' 'bb' '=' 'bb' '+' '1.
echo ' '' '' '' '' '' '' '' 'if' '"("sameoppo")"' 'abba' '=' 'abba' '+' '1.
echo ' '' '' '' '' '' '' '' 'if' '"("samepartner")"' 'antiparallel' '=' 'antiparallel' '+' '1.
echo ' '' '' '' '' '' '' '' 'if' '"("diffpartner")"' 'poly2' '=' 'poly2' '+' '1.' '
echo ' '' '' '' '' '' '' '' 'if' '"("diffpartner_samechai")"' 'head2tailsame' '=' 'head2tailsame' '+' '1.
echo ' '' '' '' '' '' '' '' 'if' '"("diffpartner_oppochai")"' 'head2tailoppo' '=' 'head2tailoppo' '+' '1.
echo ' '' '' '' '' '' '' '' 'if' '"("iindex' ''>'=' '2' '.and.' 'jindex' ''>'=' '2")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'fullyassembeled' '=' 'fullyassembeled' '+' '1.
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("diffpartner_oppochai' '.and.' 'diffpartner_samechai")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'fullass_o' '=' 'fullass_o' '+' '1.
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' 'if' '"("diffpartner_samechai' '.and.' 'samepartner")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'fullass_s' '=' 'fullass_s' '+' '1.
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' 'end' 'if
echo ' '' '' '' 'enddo' 'eachcube
echo ' '' '' '' '!' 'normalize' 'order' 'parameters' 'by' 'the' 'number' 'of' 'cubes' '
echo ' '' '' '' 'if' '"("na' '/=' '0")"' 'then' '!' 'if' 'the' 'system' 'is' 'not' 'entirely' 'b-chirality' 'squares
echo ' '' '' '' '' '' '' '' 'aa' '=' 'aa' '/' 'real"("na")"
echo ' '' '' '' 'end' 'if' '
echo ' '' '' '' 'if' '"("na' '/=' 'cube")"' 'then' '!' 'if' 'the' 'system' 'is' 'not' 'entirely' 'a-chirality' 'squares
echo ' '' '' '' '' '' '' '' 'bb' '=' 'bb' '/' 'real' '"("cube' '-' 'na")"
echo ' '' '' '' 'end' 'if
echo ' '' '' '' 'abba' '=' 'abba' '/' 'real' '"("cube")"
echo ' '' '' '' 'poly1' '=' 'poly1' '/' 'real"("cube")"
echo ' '' '' '' 'head2tailsame' '=' 'head2tailsame' '/' 'real"("cube")"
echo ' '' '' '' 'head2tailoppo' '=' 'head2tailoppo' '/' 'real"("cube")"
echo ' '' '' '' 'antiparallel' '=' 'antiparallel' '/' 'real"("cube")"
echo ' '' '' '' 'poly2' '=' 'poly2' '/' 'real"("cube")"
echo ' '' '' '' 'fullyassembeled' '=' 'fullyassembeled' '/' 'real"("cube")"
echo ' '' '' '' 'fullass_o' '=' 'fullass_o' '/' 'real"("cube")"
echo ' '' '' '' 'fullass_s' '=' 'fullass_s' '/' 'real"("cube")"
echo end' 'subroutine' 'determine_assembly
echo 
echo !' '//' 'percolation' '//' '
echo 
echo logical' 'function' 'determine_percolation' '"("n_clusters")"' '!' '#percy
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")",' 'intent"("out")"' '::' 'n_clusters' '!' 'number' 'of' 'clusters' 'identified' 'by' 'the' 'percolation' 'algorithm' '
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'logical,' 'parameter' '::' 'perc_debug' '=' '"(""("debug' ''>'=' '1")"' '.and.' '.true.")"
echo ' '' '' '' 'logical,' 'dimension"("ndim")"' '::' 'percolation' '
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'n
echo ' '' '' '' 'type"("id")"' '::' 'a' '
echo 
echo ' '' '' '' '!' 'intialize' 'peroclation' 'conditions
echo ' '' '' '' 'call' 'initialize_percolation' '"("")"
echo ' '' '' '' 'determine_percolation' '=' '.false.
echo ' '' '' '' '!' 'loop' 'through' 'all' 'atoms' 'and' 'begin' 'cluster' 'analysis' 'if' 'the' 'particle' 'has' 'not' 'yet' 'been' 'visited
echo ' '' '' '' 'n' '=' '0
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"(".not.' 'square"("i")"'%'circle"("m")"'%'percy'%'visited")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'n' '=' 'n' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("perc_debug' '.and.' '"("debug' ''>'=' '2")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("'*','*'")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("'*',\'"("\"Cluster' '\",' 'I4,' '\"' 'Analysis\"")"\'")"' 'n
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("'*',\'"("\"Root' 'Node:' '\",' '2I5")"\'")"' 'i,' 'm' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("'*','*'")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'percolation"("1")"' '=' '.false.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'percolation"("2")"' '=' '.false.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'a'%'one' '=' 'i' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'a'%'two' '=' 'm
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'clusteranal' '"("n,' 'percolation,' 'a")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("percolation"("1")"' '.and.' 'percolation"("2")"")"' 'determine_percolation' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' 'enddo
echo 
echo ' '' '' '' 'n_clusters' '=' 'n
echo ' '' '' '' 'if' '"("perc_debug")"' 'then' '
echo ' '' '' '' '' '' '' '' 'if' '"("determine_percolation")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("'*','*'")"' '\"determine_percolation:' '\",' 'n,\"' 'clusters' 'were' 'identified,' 'at' 'least' 'one' 'of' 'which' 'achieved' 'a' 'percolated' 'state.\"
echo ' '' '' '' '' '' '' '' 'else
echo ' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("'*','*'")"' '\"determine_percolation:' '\",' 'n,\"' 'clusters' 'were' 'identified,' 'none' 'of' 'which' 'achieved' 'a' 'percolated' 'state.\"
echo ' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' 'endif
echo end' 'function' 'determine_percolation
echo 
echo subroutine' 'initialize_percolation"("")"' '!' '#percy
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'i,' 'm' '!' 'indexing' 'parameters
echo 
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'percy'%'visited' '=' '.false.
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'percy'%'cluster' '=' '0
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'percy'%'pnode' '=' 'nullset"("")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'percy'%'rvec'%'r"("1")"' '=' '0.
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'percy'%'rvec'%'r"("2")"' '=' '0.
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' 'enddo
echo end' 'subroutine' 'initialize_percolation
echo 
echo recursive' 'subroutine' 'clusteranal"("clust,' 'perc,' 'a")"' '!' '#percy
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'logical,' 'parameter' '::' 'clusteranal_debug' '=' '"(""("debug' ''>'=' '2")"' '.and.' '.true.")"
echo ' '' '' '' 'real"("kind=dbl")",' 'parameter' '::' 'cluster_dist' '=' 'sigma3
echo ' '' '' '' 'integer,' 'intent"("in")"' '::' 'clust
echo ' '' '' '' 'logical,' 'dimension"("ndim")"' '::' 'perc
echo ' '' '' '' 'type"("id")",' 'intent' '"("in")"' '::' 'a
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("id")"' '::' 'b' '
echo ' '' '' '' 'integer' '::' 'n,' 'q
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'dist' '
echo ' '' '' '' 'type"("position")"' '::' 'dvec
echo 
echo ' '' '' '' '!' 'mark' 'that' 'the' 'current' 'node' 'has' 'been' 'visited
echo ' '' '' '' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'percy'%'visited' '=' '.true.
echo ' '' '' '' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'percy'%'cluster' '=' 'clust' '
echo 
echo ' '' '' '' '!' 'loop' 'through' 'all' 'partciles' 'that' 'are' 'uplist' 'or' 'down' 'list' 'of' 'a
echo ' '' '' '' 'n' '=' '0
echo ' '' '' '' 'upnab:' 'do' '
echo ' '' '' '' '' '' '' '' 'n' '=' 'n' '+' '1' '
echo ' '' '' '' '' '' '' '' 'b' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'upnab"("n")"
echo ' '' '' '' '' '' '' '' 'if' '"("b'%'one' '==' '0")"' 'exit
echo ' '' '' '' '' '' '' '' 'dist' '=' 'distance"("square"("a'%'one")"'%'circle"("a'%'two")",' 'square"("b'%'one")"'%'circle"("b'%'two")"")"
echo ' '' '' '' '' '' '' '' '!' 'if' 'the' 'pair' 'are' 'oppositely' 'polarized' 'and' 'within' 'the' 'minimum' 'distance' '
echo ' '' '' '' '' '' '' '' '!' 'or' 'the' 'pair' 'are' 'in' 'the' 'same' 'grouping
echo ' '' '' '' '' '' '' '' 'if' '"("clusteranal_debug")"' 'write' '"("'*',\'"("\"Compare' '\",' '2I5,' '\"' 'to' '\",' '2I5,' '\"' '"("\",' 'I2,' 'F6.2,\"")"\"")"\'")"' 'a'%'one,' ''&'
echo ' '' '' '' '' '' '' '' '' '' '' '' 'a'%'two,' 'b'%'one,' 'b'%'two,' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'pol' ''*'' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'pol,' 'dist
echo ' '' '' '' '' '' '' '' 'if' '"(""(""("dist' ''<'=' 'cluster_dist")"' '.and.' '"("square"("a'%'one")"'%'circle"("a'%'two")"'%'pol' ''*'' ''&'
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'pol' '==' '-1")"")"' '.or.' '"("a'%'one' '==' 'b'%'one")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'difference' 'vector' 'between' 'the' 'two
echo ' '' '' '' '' '' '' '' '' '' '' '' 'dvec' '=' 'distance_vector' '"("square"("a'%'one")"'%'circle"("a'%'two")",' 'square"("b'%'one")"'%'circle"("b'%'two")"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("square"("b'%'one")"'%'circle"("b'%'two")"'%'percy'%'visited")"' 'then' '!' 'has' 'the' 'other' 'verticie' 'already' 'been' 'visited?
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'compare' 'the' 'current' 'spanning' 'vector' 'the' 'one' 'that' 'has' 'been' 'stored' 'with' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'dvec'%'r"("q")"' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'percy'%'rvec'%'r"("q")"' '+' 'dvec'%'r"("q")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'determine' 'if' 'percolation' 'has' 'occured' 'in' 'each' 'dimensions
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("abs"("square"("b'%'one")"'%'circle"("b'%'two")"'%'percy'%'rvec'%'r"("q")"' '-' 'dvec'%'r"("q")"")"' ''>'=' '"("region' '-' 'tol")"")"' 'perc"("q")"' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'calculate' 'and' 'store' 'the' 'spanning' 'vector
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'percy'%'rvec'%'r"("q")"' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'percy'%'rvec'%'r"("q")"' '+' 'dvec'%'r"("q")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'call' 'the' 'recursive' 'subroutine
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'percy'%'pnode' '=' 'a
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("clusteranal_debug")"' 'write"("'*',\'"("\"Start' 'Recursion:' '\",' '2I5")"\'")"' 'b'%'one,' 'b'%'two
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'clusteranal' '"("clust,' 'perc,' 'b")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("clusteranal_debug")"' 'write"("'*',\'"("\"End' 'Recursion:' '\",' '2I5")"\'")"' 'b'%'one,' 'b'%'two
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' 'enddo' 'upnab
echo 
echo ' '' '' '' 'n' '=' '0
echo ' '' '' '' 'dnnab:' 'do' '
echo ' '' '' '' '' '' '' '' 'n' '=' 'n' '+' '1' '
echo ' '' '' '' '' '' '' '' 'b' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'dnnab"("n")"
echo ' '' '' '' '' '' '' '' 'if' '"("b'%'one' '==' '0")"' 'exit
echo ' '' '' '' '' '' '' '' 'dist' '=' 'distance"("square"("a'%'one")"'%'circle"("a'%'two")",' 'square"("b'%'one")"'%'circle"("b'%'two")"")"
echo ' '' '' '' '' '' '' '' '!' 'if' 'the' 'pair' 'are' 'oppositely' 'polarized' 'and' 'within' 'the' 'minimum' 'distance' '
echo ' '' '' '' '' '' '' '' '!' 'or' 'the' 'pair' 'are' 'in' 'the' 'same' 'grouping
echo ' '' '' '' '' '' '' '' 'if' '"("clusteranal_debug")"' 'write' '"("'*',\'"("\"Compare' '\",' '2I5,' '\"' 'to' '\",' '2I5,' '\"' '"("\",' 'I2,' 'F6.2,\"")"\"")"\'")"' 'a'%'one,' ''&'
echo ' '' '' '' '' '' '' '' '' '' '' '' 'a'%'two,' 'b'%'one,' 'b'%'two,' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'pol' ''*'' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'pol,' 'dist
echo ' '' '' '' '' '' '' '' 'if' '"(""(""("dist' ''<'=' 'cluster_dist")"' '.and.' '"("square"("a'%'one")"'%'circle"("a'%'two")"'%'pol' ''*'' ''&'
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'pol' '==' '-1")"")"' '.or.' '"("a'%'one' '==' 'b'%'one")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'difference' 'vector' 'between' 'the' 'two
echo ' '' '' '' '' '' '' '' '' '' '' '' 'dvec' '=' 'distance_vector' '"("square"("a'%'one")"'%'circle"("a'%'two")",' 'square"("b'%'one")"'%'circle"("b'%'two")"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("square"("b'%'one")"'%'circle"("b'%'two")"'%'percy'%'visited")"' 'then' '!' 'has' 'the' 'other' 'verticie' 'already' 'been' 'visited?
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'compare' 'the' 'current' 'spanning' 'vector' 'the' 'one' 'that' 'has' 'been' 'stored' 'with' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'dvec'%'r"("q")"' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'percy'%'rvec'%'r"("q")"' '+' 'dvec'%'r"("q")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'determine' 'if' 'percolation' 'has' 'occured' 'in' 'each' 'dimensions
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("abs"("square"("b'%'one")"'%'circle"("b'%'two")"'%'percy'%'rvec'%'r"("q")"' '-' 'dvec'%'r"("q")"")"' ''>'=' '"("region' '-' 'tol")"")"' 'perc"("q")"' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'calculate' 'and' 'store' 'the' 'spanning' 'vector
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'percy'%'rvec'%'r"("q")"' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'percy'%'rvec'%'r"("q")"' '+' 'dvec'%'r"("q")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'call' 'the' 'recursive' 'subroutine
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'percy'%'pnode' '=' 'a
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("clusteranal_debug")"' 'write"("'*',\'"("\"Start' 'Recursion:' '\",' '2I5")"\'")"' 'b'%'one,' 'b'%'two
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'clusteranal' '"("clust,' 'perc,' 'b")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("clusteranal_debug")"' 'write"("'*',\'"("\"End' 'Recursion:' '\",' '2I5")"\'")"' 'b'%'one,' 'b'%'two
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' 'enddo' 'dnnab
echo end' 'subroutine' 'clusteranal
echo 
echo !' '//' 'nematic' 'order' 'parameter' '//
echo 
echo subroutine' 'determine_nematic"("nematic")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'nematic
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")",' 'dimension"("cube")"' '::' 'phi
echo ' '' '' '' 'type"("position")",' 'dimension"("mer")"' '::' 'rcircles' '!' 'position' 'of' 'the' 'group' 'of' 'particles' 'making' 'up' 'the' 'square
echo ' '' '' '' 'type"("position")"' '::' 'dr
echo ' '' '' '' 'integer' '::' 'i,' 'j,' 'm' ',' 'q,' 'nem_count' '!' 'indexing' 'parameters
echo 
echo ' '' '' '' '!' 'intialize' 'the' 'order' 'parameter
echo ' '' '' '' 'phi' '=' '0.
echo ' '' '' '' 'nematic' '=' '0.' '
echo ' '' '' '' 'nem_count' '=' '0
echo 
echo ' '' '' '' '!' 'calculate' 'and' 'store' 'the' 'real' 'angle' 'of' 'each' 'cube' 'relative' 'to' 'the' 'x-axis
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'real' 'position' 'of' 'all' 'circles
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'real' 'position' 'of' 'the' 'first' 'circle
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'rcircles"("m")"'%'r"("q")"' '=' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("q")"' '+' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"' ''*'' 'tsl
echo ' '' '' '' '' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '' '' '' '' 'call' 'apply_periodic_boundaries' '"("rcircles"("m")"")"
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'angle' 'of' 'the' 'particle' 'relative' 'to' 'the' 'x-axis
echo ' '' '' '' '' '' '' '' 'phi"("i")"' '=' '0.
echo ' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'dr'%'r"("q")"' '=' 'rcircles"("1")"'%'r"("q")"' '-' 'rcircles"("2")"'%'r"("q")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("dr'%'r"("q")"' ''>'=' '0.5'*'region")"' 'dr'%'r"("q")"' '=' 'dr'%'r"("q")"' '-' 'region' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("dr'%'r"("q")"' ''<'' '-0.5'*'region")"' 'dr'%'r"("q")"' '=' 'dr'%'r"("q")"' '+' 'region
echo ' '' '' '' '' '' '' '' '' '' '' '' 'phi"("i")"' '=' 'phi"("i")"' '+' '"("dr'%'r"("q")"' ''*''*'' '2")"
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' 'phi"("i")"' '=' 'sqrt"("phi"("i")"")"' '
echo ' '' '' '' '' '' '' '' 'phi"("i")"' '=' '"("dr'%'r"("1")"")"' '/' 'phi"("i")"
echo ' '' '' '' '' '' '' '' 'phi"("i")"' '=' 'acos"("phi"("i")"")"' '!' 'bounds' '[-1,' '1],' 'range' '[0,' 'pi]' '
echo ' '' '' '' '' '' '' '' 'if' '"("dr'%'r"("2")"' ''<'' '0")"' 'phi"("i")"' '=' '-phi"("i")"
echo ' '' '' '' 'end' 'do
echo 
echo ' '' '' '' '!' 'calculate' 'the' 'difference' 'in' 'orientation' 'between' 'all' 'cubic' 'pairs' '
echo ' '' '' '' 'do' 'i' '=' '1,' '"("cube' '-' '1")"
echo ' '' '' '' '' '' '' '' 'do' 'j' '=' 'i' '+' '1,' 'cube' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'nematic' '=' 'nematic' '+' '"("cos"("phi"("i")"' '-' 'phi"("j")"")"' ''*''*'' '2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'nem_count' '=' 'nem_count' '+' '1
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' 'enddo
echo ' '' '' '' 'nematic' '=' 'nematic' '/' 'real"("nem_count")"' '
echo ' '' '' '' 'nematic' '=' '"("3.' ''*'' 'nematic' '-' '1.")"' '/' '2.
echo end' 'subroutine' 'determine_nematic
echo 
echo 
echo !' ''*''*'' 'event' 'scheduling' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo subroutine' 'forward' '"("next_event,' 'a,' 'b")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("event")"' '::' 'next_event
echo ' '' '' '' 'type"("id")",' 'intent"("inout")"' '::' 'a,' 'b' '!' 'uplist' 'and' 'downlist' 'event' 'pair' '
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'q
echo ' '' '' '' 'integer' '::' 'check
echo 
echo ' '' '' '' 'check' '=' '0
echo ' '' '' '' 'do
echo ' '' '' '' '' '' '' '' '!' 'find' 'and' 'save' 'the' 'next' 'event' '
echo ' '' '' '' '' '' '' '' 'n_events' '=' 'n_events' '+' '1
echo ' '' '' '' '' '' '' '' 'next_event' '=' 'reset_event' '"("")"
echo ' '' '' '' '' '' '' '' 'i' '=' 'findnextevent"("eventTree")"
echo ' '' '' '' '' '' '' '' 'if' '"("i' ''<'=' 'mols")"' 'then' '!' 'collision' 'event
echo ' '' '' '' '' '' '' '' '' '' '' '' 'a' '=' 'mol2id"("i")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'next_event' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'schedule
echo ' '' '' '' '' '' '' '' '' '' '' '' 'b' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'schedule'%'partner
echo ' '' '' '' '' '' '' '' 'elseif' '"("i' '==' 'mols+1")"' 'then' '!' 'ghost' 'event
echo ' '' '' '' '' '' '' '' '' '' '' '' 'next_event' '=' 'ghost_event
echo ' '' '' '' '' '' '' '' '' '' '' '' 'a'%'one' '=' 'cube' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' 'a'%'two' '=' '0
echo ' '' '' '' '' '' '' '' '' '' '' '' 'b' '=' 'ghost_event'%'partner
echo ' '' '' '' '' '' '' '' 'endif
echo 
echo ' '' '' '' '' '' '' '' '!' 'notify' 'user' 'about' 'next' 'event
echo ' '' '' '' '' '' '' '' 'if' '"("debug' ''>'=' '1")"' 'then
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("a'%'one' ''<'=' 'cube")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write"("simiounit,110")"' 'n_events,' 'next_event'%'time,' 'a'%'two,' 'a'%'one,' 'b'%'two,' 'b'%'one,' 'next_event'%'type
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '110' 'format"("\'' 'event' '\',' 'I8,' '\'' 'in' '\',' 'F8.5,' '\'' 'seconds:' '\',' 'I3,' '\'' 'of' '\',' 'I5,' '\'' 'will' 'collide' 'with' '\',' ''&'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'I3,\'' 'of' '\',' 'I5,' '\'' '"("type' '\',' 'I3,\'")".\'")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' 'if' '"("a'%'one' '==' '"("cube' '+' '1")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("simiounit,' '120")"' 'n_events,' 'next_event'%'time,' 'b'%'one' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '120' 'format"("\'' 'event' '\',' 'I8,' '\'' 'in' '\',' 'F8.5,' '\'' 'seconds:' 'group' '\',' 'I5,\'' 'will' 'collide' 'with' 'a' 'ghost' 'particle\'")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' 'endif
echo 
echo ' '' '' '' '' '' '' '' '!' 'if' 'step' 'length' 'is' 'less' 'than' 'zero' '
echo ' '' '' '' '' '' '' '' 'if' '"("next_event'%'time' ''<'' '0")"' 'then' '!' 'abort
echo ' '' '' '' '' '' '' '' '' '' '' '' 'write"("simiounit,'*'")"' '\'forward:' 'next' 'time' 'calculated.' 'reseting' 'simulation' 'from' 'save' 'files\'
echo ' '' '' '' '' '' '' '' '' '' '' '' 'call' 'restart' '"("")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'check' '=' 'check' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("check' ''>'' '100")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("simiounit,' ''*'")"' '\'forward:' 'unable' 'to' 'restart' 'system' 'after' 'negative' 'time' 'calculation\'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'exit"("")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'else
echo ' '' '' '' '' '' '' '' '' '' '' '' 'exit
echo ' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' 'enddo
echo 
echo ' '' '' '' '!' 'subtract' 'elapsed' 'times' 'from' 'event' 'calander
echo ' '' '' '' '!' 'TODO:' 'store' 'event' 'times' 'as' 'occuring' 'relative' 'to' 'the' 'current' 'position' 'in' 'time,' 'which' 'removes' 'this' 'step' 'and' 'possible' 'O"("N")"' 'calculation' 'each' 'step
echo ' '' '' '' '!' '"("or' 'store' 'events' 'relative' 'to' 'the' 'most' 'recent' 'false' 'position' 'update,' 'and' 'update' 'the' 'events' 'times' 'at' 'each' 'false' 'position' 'update")"
echo ' '' '' '' 'timenow' '=' 'timenow' '+' 'next_event'%'time
echo ' '' '' '' 'timeperiod' '=' 'timeperiod' '+' 'next_event'%'time' '
echo ' '' '' '' 'tsl' '=' 'tsl' '+' 'next_event'%'time
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube' '
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'schedule'%'time' '=' 'square"("i")"'%'circle"("m")"'%'schedule'%'time' '-' 'next_event'%'time' '
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' 'end' 'do' '
echo ' '' '' '' 'ghost_event'%'time' '=' 'ghost_event'%'time' '-' 'next_event'%'time
echo ' '' '' '' 'if' '"("debug' ''>'=' '1")"' 'then' '
echo ' '' '' '' '' '' '' '' 'if' '"("check_boundaries"("")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("'*','*'")"' '\'forward:' 'bounary' 'overlap.' 'program' 'will' 'abort' 'now\'
echo ' '' '' '' '' '' '' '' '' '' '' '' 'call' 'exit"("")"
echo ' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' 'endif
echo end' 'subroutine' 'forward
echo 
echo !' '//' 'collision' 'events' '//
echo 
echo subroutine' 'predict"("a,' 'b")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("id")",' 'intent"("in")"' '::' 'a,' 'b' '!' 'pair' '
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("position")"' '::' 'rij
echo ' '' '' '' 'type"("velocity")"' '::' 'vij' '
echo ' '' '' '' 'type"("event")"' '::' 'prediction
echo ' '' '' '' 'integer' '::' 'j,' 'n,' 'q
echo 
echo ' '' '' '' '!' 'check' 'that' 'b' 'is' 'uplist' 'of' 'a' '
echo ' '' '' '' '!' 'otherwise' 'leave' 'subroutine' '
echo ' '' '' '' 'if' '"(""("a'%'one' ''>'' 'b'%'one")"' '.or.' '"(""("a'%'two' ''>'=' 'b'%'two")"' '.and.' '"("a'%'one' '==' 'b'%'one")"")"")"' 'return' '
echo 
echo ' '' '' '' '!' 'calculate' 'rij' 'and' 'vij' '
echo ' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'false' 'position' 'of' 'the' 'particle' 'pair
echo ' '' '' '' '' '' '' '' 'rij'%'r"("q")"' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'fpos'%'r"("q")"' '-' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'fpos'%'r"("q")"
echo ' '' '' '' '' '' '' '' 'vij'%'v"("q")"' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'vel'%'v"("q")"' '-' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'vel'%'v"("q")"
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'real' 'position' 'of' 'the' 'particle' 'pair
echo ' '' '' '' '' '' '' '' 'rij'%'r"("q")"' '=' 'rij'%'r"("q")"' '+' 'vij'%'v"("q")"' ''*'' 'tsl
echo ' '' '' '' '' '' '' '' '!' 'apply' 'minimum' 'image' 'convention
echo ' '' '' '' '' '' '' '' 'if' '"("rij'%'r"("q")"' ''>'=' '"("0.5' ''*'' 'region")"")"' 'rij'%'r"("q")"' '=' 'rij'%'r"("q")"' '-' 'region' '
echo ' '' '' '' '' '' '' '' 'if' '"("rij'%'r"("q")"' ''<'' '"("-0.5' ''*'' 'region")"")"' 'rij'%'r"("q")"' '=' 'rij'%'r"("q")"' '+' 'region' '
echo ' '' '' '' 'end' 'do' '
echo 
echo ' '' '' '' '!' 'predict' 'next' 'event' 'between' 'pair' '
echo ' '' '' '' 'prediction' '=' 'reset_event"("")"
echo ' '' '' '' 'if' '"("a'%'one' '==' 'b'%'one")"' 'then' '!' 'if' 'the' 'particle' 'pair' 'are' 'part' 'of' 'the' 'same' 'group' '
echo ' '' '' '' '' '' '' '' 'if' '"("neighborbonded' '"("a'%'two,' 'b'%'two")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'prediction' '=' 'neighborbond_event' '"("rij,' 'vij,' 'b'%'one,' 'b'%'two")"
echo ' '' '' '' '' '' '' '' 'else' 'if' '"("crossbonded' '"("a'%'two,' 'b'%'two")"")"' 'then
echo ' '' '' '' '' '' '' '' '' '' '' '' 'prediction' '=' 'crossbond_event' '"("rij,' 'vij,' 'b'%'one,' 'b'%'two")"
echo ' '' '' '' '' '' '' '' 'else
echo ' '' '' '' '' '' '' '' '' '' '' '' 'prediction' '=' 'hardsphere_event' '"("rij,' 'vij,' 'b'%'one,' 'b'%'two")"
echo ' '' '' '' '' '' '' '' 'end' 'if
echo ' '' '' '' 'else' 'if' '"("b'%'one' ''>'' 'a'%'one")"' 'then' '!' 'if' 'b' 'is' 'an' 'uplist' 'group' 'of' 'a' '
echo ' '' '' '' '' '' '' '' 'if' '"(""("square"("a'%'one")"'%'circle"("a'%'two")"'%'pol' ''*'' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'pol")"' '/=' '0")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'prediction' '=' 'polsphere_event' '"("rij,' 'vij,' 'b'%'one,' 'b'%'two")"
echo ' '' '' '' '' '' '' '' 'else' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'prediction' '=' 'hardsphere_event' '"("rij,' 'vij,' 'b'%'one,' 'b'%'two")"
echo ' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' 'end' 'if' '
echo 
echo ' '' '' '' '!' 'schedule' 'event' 'between' 'pair,' 'if' 'sooner
echo ' '' '' '' 'if' '"("sooner"("prediction,' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'schedule")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'schedule' '=' 'prediction
echo ' '' '' '' 'end' 'if' '
echo end' 'subroutine' 'predict
echo 
echo type"("event")"' 'function' 'neighborbond_event' '"("rij,' 'vij,' 'j,' 'n")"
echo ' '' '' '' 'implicit' 'none' '' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("position")",' 'intent"("in")"' '::' 'rij' '
echo ' '' '' '' 'type"("velocity")",' 'intent"("in")"' '::' 'vij' '
echo ' '' '' '' 'integer,' 'intent"("in")"' '::' 'j' '!' 'uplist' 'group' '
echo ' '' '' '' 'integer,' 'intent"("in")"' '::' 'n' '!' 'uplist' 'particle' 'of' 'uplist' 'group' '
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'aij,' 'bij,' 'icij,' 'ocij' '!' 'quadratic' 'equation' 'constants' 'wrt' 'inner' 'and' 'outer' 'neighbor' 'bond' '
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'idiscr,' 'odiscr' '!' 'discrimenant' 'wrt' 'icij' 'and' 'ocij' 'respectively
echo 
echo ' '' '' '' '!' 'determine' 'the' 'event' 'partner
echo ' '' '' '' 'neighborbond_event'%'partner'%'one' '=' 'j
echo ' '' '' '' 'neighborbond_event'%'partner'%'two' '=' 'n' '
echo 
echo ' '' '' '' '!' 'calculate' 'quadratic' 'parameters' '
echo ' '' '' '' 'aij' '=' '"("vij'%'v"("1")"' ''*''*'' '2")"' '+' '"("vij'%'v"("2")"' ''*''*'' '2")"
echo ' '' '' '' 'bij' '=' '"("rij'%'r"("1")"' ''*'' 'vij'%'v"("1")"")"' '+' '"("rij'%'r"("2")"' ''*'' 'vij'%'v"("2")"")"
echo ' '' '' '' 'icij' '=' '"("rij'%'r"("1")"' ''*''*'' '2")"' '+' '"("rij'%'r"("2")"' ''*''*'' '2")"' '-' '"("inbond' ''*''*'' '2")"
echo ' '' '' '' 'ocij' '=' '"("rij'%'r"("1")"' ''*''*'' '2")"' '+' '"("rij'%'r"("2")"' ''*''*'' '2")"' '-' '"("onbond' ''*''*'' '2")"
echo ' '' '' '' 'idiscr' '=' '"("bij' ''*''*'' '2")"' '-' '"("aij' ''*'' 'icij")"
echo ' '' '' '' 'odiscr' '=' '"("bij' ''*''*'' '2")"' '-' '"("aij' ''*'' 'ocij")"
echo 
echo ' '' '' '' '!' 'determine' 'the' 'event' 'type' 'and' 'time' '
echo ' '' '' '' 'if' '"("bij' ''<'' '0.")"' 'then' '!' 'the' 'centers' 'are' 'approaching
echo ' '' '' '' '' '' '' '' 'if' '"("idiscr' ''>'' '0.")"' 'then' '!' 'the' 'centers' 'will' 'collide' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'neighborbond_event'%'type' '=' '8' '!' 'an' 'event' 'will' 'occur' 'at' 'the' 'inner' 'bond' 'length
echo ' '' '' '' '' '' '' '' '' '' '' '' 'neighborbond_event'%'time' '=' '"("-bij' '-' 'sqrt"("idiscr")"")"' '/' 'aij
echo ' '' '' '' '' '' '' '' 'else' '!' 'the' 'repulsive' 'centers' 'will' 'miss' 'each' 'other' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'neighborbond_event'%'type' '=' '9' '!' 'an' 'event' 'will' 'take' 'place' 'at' 'the' 'outer' 'bond' 'length
echo ' '' '' '' '' '' '' '' '' '' '' '' 'neighborbond_event'%'time' '=' '"("-bij' '+' 'sqrt"("odiscr")"")"' '/' 'aij
echo ' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' 'else' '!' 'the' 'centers' 'are' 'receding
echo ' '' '' '' '' '' '' '' 'neighborbond_event'%'type' '=' '9' '!' 'an' 'event' 'will' 'occur' 'at' 'the' 'outer' 'bond' 'length' '
echo ' '' '' '' '' '' '' '' 'neighborbond_event'%'time' '=' '"("-bij' '+' 'sqrt"("odiscr")"")"' '/' 'aij
echo ' '' '' '' 'end' 'if' '
echo end' 'function' 'neighborbond_event
echo 
echo type"("event")"' 'function' 'crossbond_event' '"("rij,' 'vij,' 'j,' 'n")"
echo ' '' '' '' 'implicit' 'none' '' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("position")",' 'intent"("in")"' '::' 'rij' '
echo ' '' '' '' 'type"("velocity")",' 'intent"("in")"' '::' 'vij' '
echo ' '' '' '' 'integer,' 'intent"("in")"' '::' 'j' '!' 'uplist' 'group' '
echo ' '' '' '' 'integer,' 'intent"("in")"' '::' 'n' '!' 'uplist' 'particle' 'of' 'uplist' 'group' '
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'aij,' 'bij,' 'icij,' 'ocij' '!' 'quadratic' 'equation' 'constants' 'wrt' 'inner' 'and' 'outer' 'neighbor' 'bond' '
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'idiscr,' 'odiscr' '!' 'discrimenant' 'wrt' 'icij' 'and' 'ocij' 'respectively
echo 
echo ' '' '' '' '!' 'determine' 'the' 'event' 'partner
echo ' '' '' '' 'crossbond_event'%'partner'%'one' '=' 'j
echo ' '' '' '' 'crossbond_event'%'partner'%'two' '=' 'n
echo 
echo ' '' '' '' '!' 'calculate' 'quadratic' 'parameters' '
echo ' '' '' '' 'aij' '=' '"("vij'%'v"("1")"' ''*''*'' '2")"' '+' '"("vij'%'v"("2")"' ''*''*'' '2")"
echo ' '' '' '' 'bij' '=' '"("rij'%'r"("1")"' ''*'' 'vij'%'v"("1")"")"' '+' '"("rij'%'r"("2")"' ''*'' 'vij'%'v"("2")"")"
echo ' '' '' '' 'icij' '=' '"("rij'%'r"("1")"' ''*''*'' '2")"' '+' '"("rij'%'r"("2")"' ''*''*'' '2")"' '-' '"("icbond' ''*''*'' '2")"
echo ' '' '' '' 'ocij' '=' '"("rij'%'r"("1")"' ''*''*'' '2")"' '+' '"("rij'%'r"("2")"' ''*''*'' '2")"' '-' '"("ocbond' ''*''*'' '2")"
echo ' '' '' '' 'idiscr' '=' '"("bij' ''*''*'' '2")"' '-' '"("aij' ''*'' 'icij")"
echo ' '' '' '' 'odiscr' '=' '"("bij' ''*''*'' '2")"' '-' '"("aij' ''*'' 'ocij")"
echo 
echo ' '' '' '' '!' 'determine' 'the' 'event' 'type' 'and' 'time' '
echo ' '' '' '' 'if' '"("bij' ''<'' '0.")"' 'then' '!' 'the' 'centers' 'are' 'approaching
echo ' '' '' '' '' '' '' '' 'if' '"("idiscr' ''>'' '0.")"' 'then' '!' 'the' 'centers' 'will' 'collide' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'crossbond_event'%'type' '=' '10' '!' 'an' 'event' 'will' 'occur' 'at' 'the' 'inner' 'bond' 'length
echo ' '' '' '' '' '' '' '' '' '' '' '' 'crossbond_event'%'time' '=' '"("-bij' '-' 'sqrt"("idiscr")"")"' '/' 'aij
echo ' '' '' '' '' '' '' '' 'else' '!' 'the' 'repulsive' 'centers' 'will' 'miss' 'each' 'other' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'crossbond_event'%'type' '=' '11' '!' 'an' 'event' 'will' 'take' 'place' 'at' 'the' 'outer' 'bond' 'length
echo ' '' '' '' '' '' '' '' '' '' '' '' 'crossbond_event'%'time' '=' '"("-bij' '+' 'sqrt"("odiscr")"")"' '/' 'aij
echo ' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' 'else' '!' 'the' 'centers' 'are' 'receding
echo ' '' '' '' '' '' '' '' 'crossbond_event'%'type' '=' '11' '!' 'an' 'event' 'will' 'occur' 'at' 'the' 'outer' 'bond' 'length' '
echo ' '' '' '' '' '' '' '' 'crossbond_event'%'time' '=' '"("-bij' '+' 'sqrt"("odiscr")"")"' '/' 'aij
echo ' '' '' '' 'end' 'if' '
echo end' 'function' 'crossbond_event
echo 
echo type"("event")"' 'function' 'hardsphere_event' '"("rij,' 'vij,' 'j,' 'n")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("position")",' 'intent"("in")"' '::' 'rij' '
echo ' '' '' '' 'type"("velocity")",' 'intent"("in")"' '::' 'vij' '
echo ' '' '' '' 'integer,' 'intent"("in")"' '::' 'j' '!' 'uplist' 'group' '
echo ' '' '' '' 'integer,' 'intent"("in")"' '::' 'n' '!' 'uplist' 'particle' 'of' 'uplist' 'group' '
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'aij,' 'bij,' 'cij,' 'discr' '!' 'quadratic' 'equation' 'constants,' 'discrimenant
echo 
echo ' '' '' '' '!' 'determine' 'the' 'event' 'partner
echo ' '' '' '' 'hardsphere_event'%'partner'%'one' '=' 'j
echo ' '' '' '' 'hardsphere_event'%'partner'%'two' '=' 'n
echo 
echo ' '' '' '' '!' 'calculate' 'quadratic' 'parameters' '
echo ' '' '' '' 'aij' '=' '"("vij'%'v"("1")"' ''*''*'' '2")"' '+' '"("vij'%'v"("2")"' ''*''*'' '2")"
echo ' '' '' '' 'bij' '=' '"("rij'%'r"("1")"' ''*'' 'vij'%'v"("1")"")"' '+' '"("rij'%'r"("2")"' ''*'' 'vij'%'v"("2")"")"
echo ' '' '' '' 'cij' '=' '"("rij'%'r"("1")"' ''*''*'' '2")"' '+' '"("rij'%'r"("2")"' ''*''*'' '2")"' '-' 'sg1sq
echo ' '' '' '' 'discr' '=' '"("bij' ''*''*'' '2")"' '-' '"("aij' ''*'' 'cij")"
echo 
echo ' '' '' '' '!' 'predict' 'if' 'the' 'hard' 'spheres' 'will' 'collide
echo ' '' '' '' 'if' '"(""("discr' ''>'' '0.")"' '.and.' '"("bij' ''<'' '0.")"")"' 'then
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'time' 'until' 'collision
echo ' '' '' '' '' '' '' '' 'hardsphere_event'%'type' '=' '1' '!' 'an' 'event' 'will' 'occur' 'at' 'sigma1
echo ' '' '' '' '' '' '' '' 'hardsphere_event'%'time' '=' '"("-bij' '-' 'sqrt"("discr")"")"' '/' 'aij
echo ' '' '' '' 'else' '
echo ' '' '' '' '' '' '' '' 'hardsphere_event'%'type' '=' '0' '!' 'no' 'event' 'will' 'occue
echo ' '' '' '' '' '' '' '' 'hardsphere_event'%'time' '=' 'bigtime
echo ' '' '' '' 'end' 'if' '
echo end' 'function' 'hardsphere_event
echo 
echo type"("event")"' 'function' 'polsphere_event' '"("rij,' 'vij,' 'j,' 'n")"
echo ' '' '' '' 'implicit' 'none' '
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("position")",' 'intent"("in")"' '::' 'rij' '
echo ' '' '' '' 'type"("velocity")",' 'intent"("in")"' '::' 'vij' '
echo ' '' '' '' 'integer,' 'intent"("in")"' '::' 'j' '!' 'uplist' 'group' '
echo ' '' '' '' 'integer,' 'intent"("in")"' '::' 'n' '!' 'uplist' 'particle' 'of' 'uplist' 'group' '
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'aij,' 'bij,' 'cij_1,' 'cij_2,' 'cij_3' '!' 'quadratic' 'equation' 'constants' 'wrt' 'to' 'discontinuities' '1,' '2,' '3,' 'and' '4
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'discr1,' 'discr2,' 'discr3' '!' 'discrimenant' 'wrt' 'cij_1,' '_2,' '_3,' 'and' '_4
echo 
echo ' '' '' '' '!' 'determine' 'the' 'event' 'partner
echo ' '' '' '' 'polsphere_event'%'partner'%'one' '=' 'j
echo ' '' '' '' 'polsphere_event'%'partner'%'two' '=' 'n
echo 
echo ' '' '' '' '!' 'calculate' 'quadratic' 'parameters' '
echo ' '' '' '' 'aij' '=' '"("vij'%'v"("1")"' ''*''*'' '2")"' '+' '"("vij'%'v"("2")"' ''*''*'' '2")"
echo ' '' '' '' 'bij' '=' '"("rij'%'r"("1")"' ''*'' 'vij'%'v"("1")"")"' '+' '"("rij'%'r"("2")"' ''*'' 'vij'%'v"("2")"")"
echo ' '' '' '' 'cij_1' '=' '"("rij'%'r"("1")"' ''*''*'' '2")"' '+' '"("rij'%'r"("2")"' ''*''*'' '2")"' '-' 'sg1sq' '!' 'first' 'discontinuity
echo ' '' '' '' 'cij_2' '=' '"("rij'%'r"("1")"' ''*''*'' '2")"' '+' '"("rij'%'r"("2")"' ''*''*'' '2")"' '-' 'sg2sq' '!' 'second' 'discontinuity
echo ' '' '' '' 'cij_3' '=' '"("rij'%'r"("1")"' ''*''*'' '2")"' '+' '"("rij'%'r"("2")"' ''*''*'' '2")"' '-' 'sg3sq' '!' 'third' 'discontinuity
echo ' '' '' '' 'discr1' '=' '"("bij' ''*''*'' '2")"' '-' '"("aij' ''*'' 'cij_1")"
echo ' '' '' '' 'discr2' '=' '"("bij' ''*''*'' '2")"' '-' '"("aij' ''*'' 'cij_2")"
echo ' '' '' '' 'discr3' '=' '"("bij' ''*''*'' '2")"' '-' '"("aij' ''*'' 'cij_3")"
echo 
echo ' '' '' '' '!' 'predict' 'the' 'next' 'event
echo ' '' '' '' 'if' '"("bij' ''<'' '0.0")"' 'then' '!' 'the' 'centers' 'are' 'approaching
echo ' '' '' '' '' '' '' '' 'if' '"("cij_2' ''<'' '0.0")"' 'then' '!' 'if' 'rij' 'is' 'within' 'the' 'first' 'well' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("discr1' ''>'' '0.0")"' 'then' '!' 'if' 'the' 'cores' 'will' 'collide
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'type' '=' '1' '!' 'an' 'event' 'will' 'occur' 'at' 'sigma1
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'time' '=' '"("-bij' '-' 'sqrt"("discr1")"")"' '/' 'aij
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' '!' 'the' 'cores' 'will' 'miss
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'type' '=' '2' '!' 'an' 'event' 'will' 'take' 'place' 'at' 'sigma2-
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'time' '=' '"("-bij' '+' 'sqrt"("discr2")"")"' '/' 'aij
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' 'else' 'if' '"("cij_3' ''<'' '0.0")"' 'then' '!' 'if' 'rij' 'is' 'within' 'the' 'second' 'well
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("discr2' ''>'' '0.0")"' 'then' '!' 'if' 'the' 'cores' 'will' 'collide
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'type' '=' '3' '!' 'an' 'event' 'will' 'take' 'place' 'at' 'sigma2+
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'time' '=' '"("-bij' '-' 'sqrt"("discr2")"")"' '/' 'aij
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' '!' 'the' 'cores' 'will' 'miss' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'type' '=' '4' '!' 'an' 'event' 'will' 'take' 'place' 'at' 'sigma3-
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'time' '=' '"("-bij' '+' 'sqrt"("discr3")"")"' '/' 'aij
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' 'else' '!' 'if' 'rij' 'is' 'outside' 'the' 'square' 'wells
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("discr3' ''>'' '0.0")"' 'then' '!' 'if' 'the' 'cores' 'will' 'collide
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'type' '=' '5' '!' 'an' 'event' 'will' 'take' 'place' 'at' 'sigma3+
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'time' '=' '"("-bij' '-' 'sqrt"("discr3")"")"' '/' 'aij
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' '!' 'the' 'outermost' 'cores' 'will' 'miss
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'type' '=' '0' '!' 'no' 'event' 'will' 'take' 'place' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'time' '=' 'bigtime
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' 'else' '!' 'the' 'centers' 'are' 'receding
echo ' '' '' '' '' '' '' '' 'if' '"("cij_2' ''<'' '0.0")"' 'then' '!' 'if' 'rij' 'is' 'within' 'the' 'first' 'well
echo ' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'type' '=' '2' '!' 'an' 'event' 'will' 'take' 'place' 'at' 'sigma2-
echo ' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'time' '=' '"("-bij' '+' 'sqrt"("discr2")"")"' '/' 'aij
echo ' '' '' '' '' '' '' '' 'else' 'if' '"("cij_3' ''<'' '0.0")"' 'then' '!' 'if' 'rij' 'is' 'within' 'the' 'second' 'well
echo ' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'type' '=' '4' '!' 'en' 'event' 'will' 'take' 'place' 'at' 'sigma' '3-
echo ' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'time' '=' '"("-bij' '+' 'sqrt"("discr3")"")"' '/' 'aij
echo ' '' '' '' '' '' '' '' 'else' '!' 'rij' 'is' 'outside' 'the' 'potential
echo ' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'type' '=' '0' '!' 'no' 'event' 'will' 'take' 'place
echo ' '' '' '' '' '' '' '' '' '' '' '' 'polsphere_event'%'time' '=' 'bigtime
echo ' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' 'end' 'if' '
echo end' 'function' 'polsphere_event
echo 
echo subroutine' 'collide' '"("a,' 'b,' 'this_event,' 'w")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("id")",' 'intent"("in")"' '::' 'a,' 'b' '!' 'ids' 'for' 'participating' 'particles' '
echo ' '' '' '' 'type"("event")",' 'intent"("in")"' '::' 'this_event' '!' 'current' 'event' '
echo ' '' '' '' 'real"("kind=dbl")",' 'intent"("out")"' '::' 'w' '!' 'accumulation' 'factor
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")",' 'parameter' '::' 'smdistance' '=' '5e-12' '!' 'How' 'small' 'can' 'this' 'number' 'be' 'with' 'out' 'impacting' 'my' 'algorith??
echo ' '' '' '' 'integer,' 'parameter' '::' 'debug_collide' '=' '0' '!' 'debugging' 'status' 'of' 'collide' 'subroutine:' '0' '==' 'off,' '1' '==' 'on
echo ' '' '' '' 'type"("position")"' '::' 'rij
echo ' '' '' '' 'type"("velocity")"' '::' 'vij
echo ' '' '' '' 'real"("kind=dbl")",' 'dimension"("ndim")"' '::' 'impulse' '!' 'the' 'transfer' 'of' 'energy' 'between' 'the' 'two' 'atoms' '
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'bij,' 'distance,' 'bump,' 'discr2,' 'discr3,' 'discr4,' 'delep' '!' 'dot' 'prroduct' 'of' 'moment' 'and' 'velocity' 'vectors,' 'distance' 'between' 'atoms
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'dispa,' 'dispb' '!' 'displacement' 'of' 'a' 'and' 'b' 'particles
echo ' '' '' '' 'integer' '::' 'q' '!' 'indexing' 'parameter' '
echo 
echo ' '' '' '' '!' 'incriment' 'the' 'number' 'of' 'collisions' 'by' '1
echo ' '' '' '' 'n_col' '=' 'n_col' '+' '1
echo 
echo ' '' '' '' '!initialize' 'parameters' '
echo ' '' '' '' 'distance' '=' '0.
echo ' '' '' '' 'bij' '=' '0.
echo ' '' '' '' 'w' '=' '0.
echo ' '' '' '' 'dispa' '=' '0.
echo ' '' '' '' 'dispb' '=' '0.
echo ' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'false' 'position' 'of' 'the' 'particle' 'pair
echo ' '' '' '' '' '' '' '' 'rij'%'r"("q")"' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'fpos'%'r"("q")"' '-' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'fpos'%'r"("q")"
echo ' '' '' '' '' '' '' '' 'vij'%'v"("q")"' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'vel'%'v"("q")"' '-' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'vel'%'v"("q")"
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'real' 'position' 'of' 'the' 'particle' 'pair
echo ' '' '' '' '' '' '' '' 'rij'%'r"("q")"' '=' 'rij'%'r"("q")"' '+' 'vij'%'v"("q")"' ''*'' 'tsl
echo ' '' '' '' '' '' '' '' '!' 'apply' 'minimum' 'image' 'convention
echo ' '' '' '' '' '' '' '' 'if' '"("rij'%'r"("q")"' ''>'=' '0.5'*'region")"' 'rij'%'r"("q")"' '=' 'rij'%'r"("q")"' '-' 'region' '
echo ' '' '' '' '' '' '' '' 'if' '"("rij'%'r"("q")"' ''<'' '-0.5'*'region")"' 'rij'%'r"("q")"' '=' 'rij'%'r"("q")"' '+' 'region' '
echo ' '' '' '' '' '' '' '' 'distance' '=' 'distance' '+' '"("rij'%'r"("q")"' ''*''*'' '2")"
echo ' '' '' '' '' '' '' '' 'bij' '=' 'bij' '+' '"("rij'%'r"("q")"' ''*'' 'vij'%'v"("q")"")"
echo ' '' '' '' '' '' '' '' '!' 'determine' 'the' 'displacement' 'of' 'either' 'particle' 'based' 'on' 'their' 'pre-collision' 'velocities
echo ' '' '' '' '' '' '' '' 'dispa' '=' 'dispa' '+' '"("square"("a'%'one")"'%'circle"("a'%'two")"'%'vel'%'v"("q")"' ''*'' 'tsl")"' ''*''*'' '2
echo ' '' '' '' '' '' '' '' 'dispb' '=' 'dispb' '+' '"("square"("b'%'one")"'%'circle"("b'%'two")"'%'vel'%'v"("q")"' ''*'' 'tsl")"' ''*''*'' '2
echo ' '' '' '' 'end' 'do' '
echo ' '' '' '' 'distance' '=' 'sqrt"("distance")"
echo ' '' '' '' '!' 'determine' 'if' 'the' 'pre-collision' 'displacement' 'of' 'either' 'particle' 'is' 'greater' 'than
echo ' '' '' '' '!' 'the' 'maximum' 'displacement' 'required' 'for' 'a' 'neighborlist' 'update
echo ' '' '' '' 'if' '"("dispa' ''>'=' 'dispb")"' 'then
echo ' '' '' '' '' '' '' '' 'dispa' '=' 'sqrt"("dispa")"
echo ' '' '' '' '' '' '' '' 'if' '"("dispa' ''>'=' 'nbrDispMax")"' 'nbrnow' '=' '.true.
echo ' '' '' '' 'else
echo ' '' '' '' '' '' '' '' 'dispb' '=' 'sqrt"("dispb")"
echo ' '' '' '' '' '' '' '' 'if' '"("dispb' ''>'=' 'nbrDispMax")"' 'nbrnow' '=' '.true.
echo ' '' '' '' 'endif
echo 
echo ' '' '' '' '!' 'notify' 'user' 'about' 'location' 'of' 'the' 'particles' 'at' 'the' 'time' 'of' 'the' 'event' '
echo ' '' '' '' 'if' '"(""("debug_collide' '==' '1")"' '.and.' '"("debug' ''>'=' '1")"")"' 'then' '
echo ' '' '' '' '' '' '' '' 'write"("simiounit,' '120")"' 'a'%'two,' 'a'%'one,' 'b'%'two,' 'b'%'one,' 'distance,' 'this_event'%'type
echo ' '' '' '' '' '' '' '' '120' 'format' '"("\'SUBROUTINE' 'collision:' 'The' 'distance' 'between' '\',' 'I3,' '\'' 'of' '\',I5,' '\'' 'and' '\',' 'I3,' '\'' 'of' '\',' 'I5,\'' 'is' '\',' 'F10.8,\'' '"("Type' '\',I2,\'")".\'")"
echo ' '' '' '' 'end' 'if' '
echo 
echo ' '' '' '' '!' 'calculate' 'collision' 'dynamics' 'based' 'on' 'event' 'type' '
echo ' '' '' '' 'if' '"("this_event'%'type' '==' '1")"' 'then' '!' 'the' 'event' 'is' 'at' 'the' 'repulsive' 'core
echo ' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-rij'%'r"("q")"' ''*'' '"("bij' '/' 'sg1sq")"
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' 'bump' '=' '0.0
echo ' '' '' '' '' '' '' '' 'n_hard' '=' 'n_hard' '+' '1
echo ' '' '' '' 'else' 'if' '"("this_event'%'type' '==' '2")"' 'then' '!' 'the' 'event' 'is' 'a' 'collision' 'at' 'sigma2-
echo ' '' '' '' '' '' '' '' 'delep' '=' 'epsilon2' '-' 'epsilon3
echo ' '' '' '' '' '' '' '' 'if' '"(""("square"("a'%'one")"'%'circle"("a'%'two")"'%'pol' ''*'' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'pol")"' '==' '-1")"' 'then' '!' 'if' 'the' 'spheres' 'are' 'attracted' 'to' 'one' 'another
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'determine' 'if' 'the' 'spheres' 'have' 'enough' 'energy' 'required' 'to' 'dissociate
echo ' '' '' '' '' '' '' '' '' '' '' '' 'discr2' '=' '"("bij' ''*''*'' '2")"' '-' '"("4.' ''*'' 'sg2sq' ''*'' 'delep")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("discr2' ''>'=' '0")"' 'then' '!' 'if' 'the' 'pair' 'meet' 'the' 'energy' 'requirement
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'the' 'pair' 'will' 'dissociate
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"(""("bij' '-' 'sqrt"("discr2")"")"' '/' '"("2.' ''*'' 'sg2sq")"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'bump' '=' '1.0
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' '!' 'the' 'pair' 'will' 'remain' 'associated' '"("\"bounce\"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"("bij' '/' 'sg2sq")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'bump' '=' '-1.0
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' 'else' '!' 'the' 'spheres' 'are' 'repeled' 'from' 'one' 'another
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'the' 'pair' 'will' 'dissociate
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"(""("bij' '-' 'sqrt"(""("bij' ''*''*'' '2")"' '+' '"("4.' ''*'' 'sg2sq' ''*'' 'delep")"")"")"/"("2.' ''*'' 'sg2sq")"")"' '!' 'CHECK' 'THIS!
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'bump' '=' '1.0
echo ' '' '' '' '' '' '' '' 'end' 'if
echo ' '' '' '' '' '' '' '' 'n_well' '=' 'n_well' '+' '1
echo ' '' '' '' 'else' 'if' '"("this_event'%'type' '==' '3")"' 'then' '!' 'the' 'event' 'is' 'a' 'collision' 'at' 'sigma2+
echo ' '' '' '' '' '' '' '' 'delep' '=' 'epsilon2' '-' 'epsilon3
echo ' '' '' '' '' '' '' '' 'if' '"(""("square"("a'%'one")"'%'circle"("a'%'two")"'%'pol' ''*'' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'pol")"' '==' '-1")"' 'then' '!' 'if' 'the' 'spheres' 'are' 'attracted' 'to' 'one' 'another
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'the' 'pair' 'will' 'associate' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"(""("bij' '+' 'sqrt"(""("bij' ''*''*'' '2")"' '+' '"("4.' ''*'' 'sg2sq' ''*'' 'delep")"")"")"' '/' '"("2.' ''*'' '"("sg2sq")"")"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'bump' '=' '-1.0
echo ' '' '' '' '' '' '' '' 'else' '!' 'the' 'spheres' 'are' 'repeled' 'from' 'one' 'another' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'determine' 'if' 'the' 'spheres' 'have' 'enough' 'energy' 'required' 'to' 'associate' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'discr2' '=' '"("bij' ''*''*'' '2")"' '-' '"("4.' ''*'' 'sg2sq' ''*'' 'delep")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("discr2' ''>'=' '0")"' 'then' '!' 'the' 'the' 'pair' 'meet' 'the' 'energy' 'requirement
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'the' 'pair' 'will' 'associate
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"(""("bij' '+' 'sqrt"("discr2")"")"' '/' '"("2.' ''*'' 'sg2sq")"")"' '!' 'CHECK' 'THIS
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'bump' '=' '-1.0
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' '!' 'the' 'pair' 'do' 'not' 'meet' 'the' 'energy' 'requirement
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'the' 'pair' 'will' 'remain' 'dissociated' '"("\"bounce\"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"("bij' '/' 'sg2sq")"' '!' 'CHECK' 'THIS
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'bump' '=' '1.0
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' 'end' 'if
echo ' '' '' '' '' '' '' '' 'n_well' '=' 'n_well' '+' '1
echo ' '' '' '' 'else' 'if' '"("this_event'%'type' '==' '4")"' 'then' '!' 'the' 'event' 'is' 'a' 'collision' 'at' 'sigma' '3-
echo ' '' '' '' '' '' '' '' 'delep' '=' 'epsilon3
echo ' '' '' '' '' '' '' '' 'if' '"(""("square"("a'%'one")"'%'circle"("a'%'two")"'%'pol' ''*'' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'pol")"' '==' '-1")"' 'then' '!' 'if' 'the' 'spheres' 'are' 'attracted' 'to' 'one' 'another
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'determine' 'if' 'the' 'spheres' 'have' 'enough' 'energy' 'required' 'to' 'dissociate
echo ' '' '' '' '' '' '' '' '' '' '' '' 'discr3' '=' 'bij' ''*''*'' '2' '-' '"("4.' ''*'' 'sg3sq' ''*'' 'delep")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("discr3' ''>'=' '0")"' 'then' '!' 'if' 'the' 'pair' 'meet' 'the' 'energy' 'requirement
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'the' 'pair' 'will' 'dissociate
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"(""("bij' '-' 'sqrt"("discr3")"")"' '/' '"("2.' ''*'' 'sg3sq")"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'bump' '=' '1.0
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' '!' 'the' 'pair' 'will' 'remain' 'associated' '"("\"bounce\"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"("bij' '/' 'sg3sq")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'bump' '=' '-1.0
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' 'else' '!' 'the' 'spheres' 'are' 'repeled' 'from' 'one' 'another
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'the' 'pair' 'will' 'dissociate
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"(""("bij' '-' 'sqrt"(""("bij' ''*''*'' '2")"' '+' '"("4.' ''*'' 'sg3sq' ''*'' 'delep")"")"")"' '/' '"("2.' ''*'' 'sg3sq")"")"' '!' 'CHECK' 'THIS!
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'bump' '=' '1.0
echo ' '' '' '' '' '' '' '' 'end' 'if
echo ' '' '' '' '' '' '' '' 'n_well' '=' 'n_well' '+' '1
echo ' '' '' '' 'else' 'if' '"("this_event'%'type' '==' '5")"' 'then' '!' 'the' 'event' 'is' 'a' 'collision' 'at' 'sigma' '3+
echo ' '' '' '' '' '' '' '' 'delep' '=' 'epsilon3
echo ' '' '' '' '' '' '' '' 'if' '"(""("square"("a'%'one")"'%'circle"("a'%'two")"'%'pol' ''*'' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'pol")"' '==' '-1")"' 'then' '!' 'if' 'the' 'spheres' 'are' 'attracted' 'to' 'one' 'another
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'the' 'pair' 'will' 'associate' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"(""("bij' '+' 'sqrt"(""("bij' ''*''*'' '2")"' '+' '"("4.' ''*'' 'sg3sq' ''*'' 'delep")"")"")"' '/' '"("2.' ''*'' '"("sg3sq")"")"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'bump' '=' '-1.0
echo ' '' '' '' '' '' '' '' 'else' '!' 'the' 'spheres' 'are' 'repeled' 'from' 'one' 'another' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'determine' 'if' 'the' 'spheres' 'have' 'enough' 'energy' 'required' 'to' 'associate' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'discr3' '=' 'bij' ''*''*'' '2' '-' '"("4.' ''*'' 'sg3sq' ''*'' 'delep")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("discr3' ''>'=' '0")"' 'then' '!' 'the' 'the' 'pair' 'meet' 'the' 'energy' 'requirement
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'the' 'pair' 'will' 'associate
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"(""("bij' '+' 'sqrt"("discr3")"")"' '/' '"("2.' ''*'' 'sg3sq")"")"' '!' 'CHECK' 'THIS
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'bump' '=' '-1.0
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' '!' 'the' 'pair' 'do' 'not' 'meet' 'the' 'energy' 'requirement
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'the' 'pair' 'will' 'remain' 'dissociated' '"("\"bounce\"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"("bij' '/' 'sg3sq")"' '!' 'CHECK' 'THIS
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'bump' '=' '1.0
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' 'end' 'if
echo ' '' '' '' '' '' '' '' 'n_well' '=' 'n_well' '+' '1
echo ' '' '' '' 'else' 'if' '"("this_event'%'type' '==' '8")"' 'then' '!' 'the' 'event' 'is' 'at' 'the' 'repulsive' 'inner' 'neighbor' 'bond' 'length
echo ' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"("bij' '/' 'inbond'*''*'2")"
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' 'bump' '=' '1.0
echo ' '' '' '' '' '' '' '' 'n_bond' '=' 'n_bond' '+' '1
echo ' '' '' '' 'else' 'if' '"("this_event'%'type' '==' '9")"' 'then' '!' 'the' 'event' 'is' 'at' 'the' 'repulsive' 'outer' 'neighbor' 'bond' 'length
echo ' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"("bij' '/' 'onbond'*''*'2")"
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' 'bump' '=' '-1.0
echo ' '' '' '' '' '' '' '' 'n_bond' '=' 'n_bond' '+' '1
echo ' '' '' '' 'else' 'if' '"("this_event'%'type' '==' '10")"' 'then' '!' 'the' 'event' 'is' 'occuring' 'at' 'the' 'repulsive' 'inner' 'cross' 'bond' 'length' '
echo ' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"("bij' '/' 'icbond'*''*'2")"
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' 'bump' '=' '1.0
echo ' '' '' '' '' '' '' '' 'n_bond' '=' 'n_bond' '+' '1
echo ' '' '' '' 'else' 'if' '"("this_event'%'type' '==' '11")"' 'then' '!' 'the' 'event' 'is' 'occuring' 'at' 'the' 'repulsive' 'outer' 'cross' 'bond' 'length
echo ' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'impulse"("q")"' '=' '-' 'rij'%'r"("q")"' ''*'' '"("bij' '/' 'ocbond'*''*'2")"
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' 'bump' '=' '-1.0
echo ' '' '' '' '' '' '' '' 'n_bond' '=' 'n_bond' '+' '1
echo ' '' '' '' 'end' 'if' '
echo 
echo ' '' '' '' 'dispa' '=' '0.
echo ' '' '' '' 'dispb' '=' '0.
echo ' '' '' '' '!' 'adjust' 'the' 'velocity' 'vector' 'of' 'each' 'atom' 'accordingly
echo ' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '!' 'adjust' 'the' 'velocity' 'of' 'both' 'colliding' 'atoms' '
echo ' '' '' '' '' '' '' '' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'vel'%'v"("q")"' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'vel'%'v"("q")"' '+' 'impulse"("q")"
echo ' '' '' '' '' '' '' '' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'vel'%'v"("q")"' '=' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'vel'%'v"("q")"' '-' 'impulse"("q")"
echo ' '' '' '' '' '' '' '' 'w' '=' 'w' '+' '"("rij'%'r"("q")"' ''*'' 'impulse"("q")"")"
echo ' '' '' '' '' '' '' '' '!' 'move' 'the' 'particles' 'a' 'small' 'distance' 'away' 'from' 'the' 'collision' 'point
echo ' '' '' '' '' '' '' '' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'fpos'%'r"("q")"' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'fpos'%'r"("q")"' '+' ''&'
echo ' '' '' '' '' '' '' '' '' '' '' '' 'bump' ''*'' 'smdistance' ''*'' 'rij'%'r"("q")"' ''*'' 'sigma2
echo ' '' '' '' '' '' '' '' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'fpos'%'r"("q")"' '=' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'fpos'%'r"("q")"' '-' ''&'
echo ' '' '' '' '' '' '' '' '' '' '' '' 'bump' ''*'' 'smdistance' ''*'' 'rij'%'r"("q")"' ''*'' 'sigma2
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'new' 'false' 'position' 'of' 'each' 'particle' 'based' 'on' 'their' 'new' 'velocities
echo ' '' '' '' '' '' '' '' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'fpos'%'r"("q")"' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'fpos'%'r"("q")"' '-' 'impulse"("q")"' ''*'' 'tsl
echo ' '' '' '' '' '' '' '' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'fpos'%'r"("q")"' '=' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'fpos'%'r"("q")"' '+' 'impulse"("q")"' ''*'' 'tsl
echo ' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'dispalcement' 'of' 'either' 'particle' 'based' 'on' 'their' 'post-collision' 'velocities
echo ' '' '' '' '' '' '' '' 'dispa' '=' 'dispa' '+' '"("square"("a'%'one")"'%'circle"("a'%'two")"'%'vel'%'v"("q")"' ''*'' 'tsl")"' ''*''*'' '2
echo ' '' '' '' '' '' '' '' 'dispb' '=' 'dispb' '+' '"("square"("b'%'one")"'%'circle"("b'%'two")"'%'vel'%'v"("q")"' ''*'' 'tsl")"' ''*''*'' '2
echo ' '' '' '' 'end' 'do' '' '
echo ' '' '' '' '!' 'apply' 'periodic' 'boundary' 'conditions
echo ' '' '' '' 'call' 'apply_periodic_boundaries"("square"("a'%'one")"'%'circle"("a'%'two")"'%'fpos")"
echo ' '' '' '' 'call' 'apply_periodic_boundaries"("square"("b'%'one")"'%'circle"("b'%'two")"'%'fpos")"
echo ' '' '' '' '!' 'determine' 'if' 'the' 'post-collision' 'displacement' 'of' 'either' 'particle' 'is' 'greater' 'than
echo ' '' '' '' '!' 'the' 'maximum' 'displacement' 'required' 'for' 'a' 'neighborlist' 'update
echo ' '' '' '' 'if' '"("dispa' ''>'=' 'dispb")"' 'then
echo ' '' '' '' '' '' '' '' 'dispa' '=' 'sqrt"("dispa")"
echo ' '' '' '' '' '' '' '' 'if' '"("dispa' ''>'=' 'nbrDispMax")"' 'nbrnow' '=' '.true.
echo ' '' '' '' 'else
echo ' '' '' '' '' '' '' '' 'dispb' '=' 'sqrt"("dispb")"
echo ' '' '' '' '' '' '' '' 'if' '"("dispb' ''>'=' 'nbrDispMax")"' 'nbrnow' '=' '.true.
echo ' '' '' '' 'endif
echo end' 'subroutine' 'collide
echo 
echo !' '//' 'ghost' 'events' '//
echo 
echo subroutine' 'ghost_collision"("temperature")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")",' 'intent"("in")"' '::' 'temperature' '!' 'system' 'temp' '
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")",' 'parameter' '::' 'mu' '=' '0.
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'sigma
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'u1,' 'u2' '!' 'random' 'numbers
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'q' '!' 'indexing' 'parameter' '
echo ' '' '' '' 'type"("position")",' 'dimension"("mer")"' '::' 'rg' '!' 'stores' 'the' 'real' 'position' 'of' 'each' 'particle' 'in' 'ghost' 'coliision
echo 
echo ' '' '' '' 'n_ghost' '=' 'n_ghost' '+' '1
echo 
echo ' '' '' '' 'sigma' '=' 'sqrt"("temperature")"
echo ' '' '' '' 'i' '=' 'ghost_event'%'partner'%'one
echo ' '' '' '' 'do' 'm' '=' '1,' 'mer' '!' 'for' 'every' 'sphere' 'in' 'the' 'square' 'formation' '
echo ' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'save' 'the' 'real' 'position' 'of' 'each' 'particle' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'rg"("mer")"'%'r"("q")"' '=' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("q")"' '+' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"' ''*'' 'tsl
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'Generate' 'a' 'pseudo' 'random' 'vector' 'components' 'based' 'on' 'a' 'Gaussian' 'distribution' 'along' 'the' 'Box-Mueller' 'algorithm
echo ' '' '' '' '' '' '' '' '' '' '' '' 'call' 'random_number' '"("u1")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'call' 'random_number' '"("u2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"' '=' 'mu' '+' '"("sigma' ''*'' 'sqrt"("' '-2.' ''*'' 'log"("u1")"")"' ''*'' 'sin' '"("twopi' ''*'' 'u2")"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'update' 'the' 'false' 'position' 'of' 'the' 'particle' 'participating' 'in' 'the' 'ghost' 'event
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("q")"' '=' 'rg"("mer")"'%'r"("q")"' '-' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"' ''*'' 'tsl
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '!' 'apply' 'periodic' 'boundary' 'conditions
echo ' '' '' '' '' '' '' '' 'call' 'apply_periodic_boundaries"("square"("i")"'%'circle"("m")"'%'fpos")"
echo ' '' '' '' 'end' 'do' '
echo end' 'subroutine' 'ghost_collision
echo 
echo type"("event")"' 'function' 'predict_ghost"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo ' '' '' '' 'predict_ghost'%'time' '=' '"("density' ''*''*'' '"("1./2.")"")"' '/' 'thermal_conductivity
echo ' '' '' '' 'predict_ghost'%'partner' '=' 'random_cube' '"("")"
echo ' '' '' '' 'predict_ghost'%'type' '=' '-1
echo end' 'function' 'predict_ghost
echo 
echo type"("id")"' 'function' 'random_cube"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'dummy' '!' 'dummy' 'variable' '
echo 
echo ' '' '' '' '!' 'select' 'a' 'random' 'cube' '
echo ' '' '' '' 'call' 'random_number' '"("dummy")"
echo ' '' '' '' 'random_cube'%'one' '=' 'ceiling"("dummy' ''*'' 'real"("cube")"")"
echo ' '' '' '' 'random_cube'%'two' '=' '0
echo end' 'function' 'random_cube
echo 
echo 
echo !' ''*''*'' 'efficiency' 'methods' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo 
echo subroutine' 'complete_reschedule"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'j,' 'n' '
echo ' '' '' '' 'type"("id")"' '::' 'a,' 'b' '
echo 
echo ' '' '' '' 'call' 'initialize_binarytree"("eventTree")"
echo ' '' '' '' 'do' 'i' '=' '1,' 'mols' '
echo ' '' '' '' '' '' '' '' 'n' '=' '0
echo ' '' '' '' '' '' '' '' 'a' '=' 'mol2id"("i")"
echo ' '' '' '' '' '' '' '' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'schedule' '=' 'reset_event"("")"
echo ' '' '' '' '' '' '' '' 'do
echo ' '' '' '' '' '' '' '' '' '' '' '' 'n' '=' 'n' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' 'b' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'upnab"("n")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("b'%'one' '==' '0")"' 'exit' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'call' 'predict' '"("a,' 'b")"
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' 'call' 'addbranch' '"("eventTree,' 'i")"
echo ' '' '' '' 'enddo
echo ' '' '' '' '!' 'schedule' 'new' 'ghost' 'event' '
echo ' '' '' '' 'ghost_event' '=' 'predict_ghost"("")"
echo ' '' '' '' 'if' '"("thermostat")"' 'call' 'addbranch' '"("eventTree,' 'mols+1")"
echo end' 'subroutine' 'complete_reschedule
echo 
echo subroutine' 'collision_reschedule"("a,' 'b")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("id")",' 'intent"("in")"' '::' 'a,' 'b
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("id")"' '::' 'j1,' 'j2' '!' 'event' 'partners' '
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'n' '' '!' 'indexing' 'parameters
echo 
echo ' '' '' '' '!' 'loop' 'through' 'all' 'particles' '
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube' '
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'if' 'any' 'particles' 'just' 'participated' 'in' 'an' 'event' 'or' 'were' 'scheduled' 'to' 'participate
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'in' 'an' 'event' 'with' 'the' 'event' 'particles,' 'reschedule' 'their' 'uplist' 'partner' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"(""(""("i' '==' 'a'%'one")"' '.and.' '"("m' '==' 'a'%'two")"")"' '.or.' '"(""("square"("i")"'%'circle"("m")"'%'schedule'%'partner'%'one' '==' 'a'%'one")"' '.and.'&'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '"("square"("i")"'%'circle"("m")"'%'schedule'%'partner'%'two' '==' 'a'%'two")"")"' '.or.' '"(""("i' '==' 'b'%'one")"' '.and.' '"("m' '==' 'b'%'two")"")"' '.or.'&'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '"(""("square"("i")"'%'circle"("m")"'%'schedule'%'partner'%'one' '==' 'b'%'one")"' '.and.' ''&'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '"("square"("i")"'%'circle"("m")"'%'schedule'%'partner'%'two' '==' 'b'%'two")"")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j1'%'one' '=' 'i
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j1'%'two' '=' 'm
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'reset' 'its' 'event' 'and' 'find' 'next' 'event' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'schedule' '=' 'reset_event"("")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'loop' 'through' 'their' 'uplist' 'neighbors' 'to' 'find' 'next' 'event' 'partner
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'n' '=' '0
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'uplist:' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'n' '=' 'n' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j2' '=' 'square"("i")"'%'circle"("m")"'%'upnab"("n")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("j2'%'one' '==' '0")"' 'exit' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'predict' '"("j1,' 'j2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'enddo' 'uplist
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'addbranch' '"("eventTree,' 'id2mol"("j1'%'one,' 'j1'%'two")"")"' '!' 'add' 'the' 'event' 'to' 'the' 'event' 'tree
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'if' 'the' 'particles' 'are' 'event' 'partners' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"(""(""("i' '==' 'a'%'one")"' '.and.' '"("m' '==' 'a'%'two")"")"' '.or.' '"(""("i' '==' 'b'%'one")"' '.and.' '"("m' '==' 'b'%'two")"")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'loop' 'through' 'downlist' 'partners' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j2'%'one' '=' 'i' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j2'%'two' '=' 'm' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'n' '=' '0
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'downlist:' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'n' '=' 'n' '+' '1' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j1' '=' 'square"("i")"'%'circle"("m")"'%'dnnab"("n")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("j1'%'one' '==' '0")"' 'exit' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'predict' '"("j1,' 'j2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("idequiv"("square"("j1'%'one")"'%'circle"("j1'%'two")"'%'schedule'%'partner,j2")"")"' 'then' '!' 'if' 'j1' 'is' 'scheduled' 'for' 'an' 'event' 'with' 'j2
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'addbranch' '"("eventTree,' 'id2mol"("j1'%'one,' 'j1'%'two")"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'enddo' 'downlist
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif' '
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' 'enddo
echo end' 'subroutine' 'collision_reschedule
echo 
echo subroutine' 'ghost_reschedule"("ghost")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer,' 'intent"("in")"' '::' 'ghost
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("id")"' '::' 'j1,' 'j2' '!' 'prediction' 'event' 'partners' '
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'n' '!' 'indexing' 'parameters' '
echo 
echo ' '' '' '' '!' 'loop' 'through' 'all' 'particles' '
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'if' 'the' 'partcle' 'either' 'participated' 'in' 'the' 'ghost' 'event,' 'or' 'was' 'scheduled' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'to' 'collide' 'with' 'a' 'particle' 'that' 'participated' 'in' 'the' 'ghost' 'event' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"(""("i' '==' 'ghost")"' '.or.' '"("square"("i")"'%'circle"("m")"'%'schedule'%'partner'%'one' '==' 'ghost")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j1'%'one' '=' 'i
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j1'%'two' '=' 'm' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'reset' 'and' 'find' 'its' 'next' 'event' 'with' 'an' 'uplist' 'particle
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("j1'%'one")"'%'circle"("j1'%'two")"'%'schedule' '=' 'reset_event"("")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'n' '=' '0' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'uplist:' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'n' '=' 'n' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j2' '=' 'square"("j1'%'one")"'%'circle"("j1'%'two")"'%'upnab"("n")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("j2'%'one' '==' '0")"' 'exit' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'predict' '"("j1,' 'j2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'enddo' 'uplist' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'addbranch' '"("eventTree,' 'id2mol"("j1'%'one,' 'j1'%'two")"")"' '!' 'add' 'the' 'event' 'to' 'the' 'event' 'tree
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'if' 'the' 'particle' 'participated' 'in' 'the' 'ghost' 'event' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("i' '==' 'ghost")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j2'%'one' '=' 'i' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j2'%'two' '=' 'm' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'find' 'any' 'downlist' 'particles' 'in' 'its' 'collision' 'path' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'n' '=' '0
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'downlist:' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'n' '=' 'n' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j1' '=' 'square"("j2'%'one")"'%'circle"("j2'%'two")"'%'dnnab"("n")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("j1'%'one' '==' '0")"' 'exit
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'predict' '"("j1,' 'j2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("idequiv"("square"("j1'%'one")"'%'circle"("j1'%'two")"'%'schedule'%'partner,j2")"")"' 'then' '!' 'if' 'j1' 'is' 'scheduled' 'for' 'an' 'event' 'with' 'j2
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'addbranch' '"("eventTree,' 'id2mol"("j1'%'one,' 'j1'%'two")"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'enddo' 'downlist' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif' '
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' 'enddo
echo end' 'subroutine' 'ghost_reschedule
echo 
echo ' '!' '//' 'cell' '+' 'neighbor' 'list' '//
echo 
echo subroutine' 'build_linkedlist"("list")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer,' 'dimension"("mols' '+' '"("nCells' ''*''*'' 'ndim")"")",' 'intent"("out")"' '::' 'list
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'q' '!' 'indexing' 'parameters' '
echo ' '' '' '' 'integer,' 'dimension' '"("ndim")"' '::' 'c' '!' 'used' 'to' 'record' 'the' 'cell' 'number' 'of' 'a' 'particle' 'in' 'each' 'dimenion' '
echo ' '' '' '' 'integer' '::' 'cellindex' '!' 'used' 'to' 'record' 'the' 'absolute' 'cell' 'number' 'of' 'each' 'particle' '
echo 
echo ' '' '' '' '!' 'reset' 'each' 'cell' 'to' '-1
echo ' '' '' '' 'do' 'i' '=' 'mols' '+' '1,' 'mols' '+' '"("nCells' ''*''*'' 'ndim")"
echo ' '' '' '' '' '' '' '' 'list' '"("i")"' '=' '-1' '
echo ' '' '' '' 'end' 'do' '
echo 
echo ' '' '' '' '!' 'create' 'a' 'linked' 'list' 'based' 'on' 'the' 'position' 'of' 'each' 'atom' '
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube' '
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'c"("q")"' '=' 'floor' '"("square"("i")"'%'circle"("m")"'%'fpos'%'r"("q")"' '/' 'lengthCell")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'cellindex' '=' '"("c"("2")"' ''*'' 'nCells")"' '+' 'c"("1")"' '+' 'mols' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' 'list"("id2mol"("i,' 'm")"")"' '=' 'list"("cellindex")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'list"("cellindex")"' '=' 'id2mol"("i,m")"
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' 'enddo
echo end' 'subroutine' 'build_linkedlist
echo 
echo subroutine' 'build_neighborlist"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer,' 'dimension"("mols' '+' '"("nCells' ''*''*'' '2")"")"' '::' 'cellList
echo ' '' '' '' 'integer' '::' 'm1x,' 'm1y,' 'm1cell' '!' 'integers' 'used' 'to' 'determine' 'the' 'reference' 'cell' '
echo ' '' '' '' 'integer' '::' 'delx,' 'dely' '!' 'used' 'to' 'shift' '
echo ' '' '' '' 'integer' '::' 'm2x,' 'm2y,' 'm2cell' '!' 'integers' 'used' 'to' 'determine' 'the' 'search' 'cell' '
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'rij
echo ' '' '' '' 'integer' '::' 'j1,' 'j2' '!' 'particle' 'pair' '
echo ' '' '' '' 'type"("id")"' '::' 'a,' 'b
echo ' '' '' '' 'integer' '::' 'i,' 'j,' 'm' '!' 'indexing' 'parameters' '
echo ' '' '' '' 'integer,' 'dimension' '"("mols")"' '::' 'nup,' 'ndn' '!' 'down' 'and' 'uplist' 'indexes' '
echo 
echo ' '' '' '' '!' 'reset' 'all' 'neighbor' 'lists' 'to' 'zero
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'upnab' '=' 'nullset"("")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'dnnab' '=' 'nullset"("")"
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' 'end' 'do' '
echo 
echo ' '' '' '' 'if' '"("debug' ''>'=' '1")"' 'write"("simiounit,'*'")"' '\'SUBROUTINE' 'build_neighborlist:' 'At' 'event\',' 'n_events,' '\'' 'the' 'maximum' 'displacement\','&'
echo ' '' '' '' '' '' '' '' '' '\'was' 'reached' 'and' 'the' 'neighborlist' 'was' 'reset.\'
echo ' '' '' '' '!' 'update' 'the' 'false' 'positions' 'of' 'each' 'particle
echo ' '' '' '' 'call' 'update_positions"("")"
echo ' '' '' '' '!' 'create' 'linked' 'list' 'to' 'build' 'the' 'neighbor' 'list' '
echo ' '' '' '' 'call' 'build_linkedlist"("cellList")"
echo ' '' '' '' '!' 'intialize' 'list' 'index' 'to' 'the' 'first' 'position' 'for' 'all' 'particles' '
echo ' '' '' '' 'nup' '=' '1
echo ' '' '' '' 'ndn' '=' '1
echo ' '' '' '' 'do' 'm1y' '=' '1,' 'nCells' '
echo ' '' '' '' '' '' '' '' 'do' 'm1x' '=' '1,' 'nCells
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'determine' 'the' 'reference' 'cell' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'm1cell' '=' '"(""("m1y' '-' '1")"' ''*'' 'nCells")"' '+' 'm1x' '+' 'mols
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'establish' 'reference' 'atoms' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'j1' '=' 'cellList' '"("m1cell")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'reference_cell:' 'do' '!' 'loop' 'through' 'each' 'atom' 'in' 'reference' 'cell' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("j1' ''<'=' '0")"' 'exit' '!' 'until' 'the' 'end' 'of' 'the' 'linked' 'list' '"("-1")"' 'is' 'reached' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'calculate' 'groupid' 'from' 'linked' 'list' 'index' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'a' '=' 'mol2id"("j1")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'loop' 'through' 'all' 'neighboring' 'cells' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'dely' '=' '-1,' '1' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'determine' 'm2y' 'including' 'wrap' 'around' 'effects' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'm2y' '=' 'm1y' '+' 'dely' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("m2y' ''>'' 'nCells")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'm2y' '=' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'else' 'if' '"("m2y' ''<'' '1")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'm2y' '=' 'nCells' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'do' 'delx' '=' '-1,' '1' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'determine' 'm2x' 'including' 'wrap' 'around' 'effects' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'm2x' '=' 'm1x' '+' 'delx' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("m2x' ''>'' 'nCells")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'm2x' '=' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'else' 'if' '"("m2x' ''<'' '1")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'm2x' '=' 'nCells
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'neighvoring' 'cell' 'to' 'search' 'through' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'm2cell' '=' '"(""("m2y' '-' '1")"' ''*'' 'nCells")"' '+' 'm2x' '+' 'mols
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'establish' 'atom' 'in' 'neighboring' 'cell' 'to' 'compare' 'to' 'j1
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j2' '=' 'cellList' '"("m2cell")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'compare:' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("j2' ''<'=' '0")"' 'exit' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("j2' ''>'' 'j1")"' 'then' '!' 'for' 'all' 'uplist' 'atoms' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'b' '=' 'mol2id"("j2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'rij' '=' 'distance"("square"("a'%'one")"'%'circle"("a'%'two")",' 'square"("b'%'one")"'%'circle"("b'%'two")"")"' '!' 'calculate' 'the' 'distance' 'between' 'pair' 'i' 'and' 'j' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'determine' 'if' 'the' 'pair' 'are' 'neighbors
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("rij' ''<'' 'nbrRadius")"' 'then' '!' 'if' 'the' 'distance' 'between' 'pair' 'i' 'and' 'j' 'is' 'less' 'than' 'the' 'max' 'search' 'radius
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"(""("nup"("j1")"' ''>'' 'nbrListSizeMax")"' '.or.' '"("ndn"("j2")"' ''>'' 'nbrListSizeMax")"")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'write' '"("'*','*'")"' '\'Too' 'many' 'neighbors' 'in' 'neighborlist.' 'Increase' 'size' 'of' 'list' 'for' 'this' 'desnity.\'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'call' 'exit' '"("")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'j' 'is' 'uplist' 'of' 'i' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'upnab"("nup"("j1")"")"' '=' 'b
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'nup' '"("j1")"' '=' 'nup' '"("j1")"' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'i' 'is' 'downlist' 'of' 'j' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("b'%'one")"'%'circle"("b'%'two")"'%'dnnab"("ndn"("j2")"")"' '=' 'a
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'ndn' '"("j2")"' '=' 'ndn' '"("j2")"' '+' '1
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j2' '=' 'cellList"("j2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'enddo' 'compare' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'j1' '=' 'cellList"("j1")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'enddo' 'reference_cell
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' 'enddo
echo ' '' '' '' 'nbrnow' '=' '.false.
echo ' '' '' '' 'dispTotal' '=' '0.
echo end' 'subroutine' 'build_neighborlist
echo 
echo !' '//' 'bianry' 'tree' '//
echo 
echo subroutine' 'initialize_binarytree"("tree")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("node")",' 'dimension"("mols+1")",' 'intent"("out")"' '::' 'tree
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'i' '!' 'indexing' 'parameter
echo ' '' '' '' 'type"("id")"' '::' 'a' '!' 'indexing' 'parameter
echo 
echo ' '' '' '' '!' 'reset' 'initial' 'node' 'of' 'binary' 'tree' '
echo ' '' '' '' 'rootnode' '=' '0
echo ' '' '' '' '!' 'loop' 'through' 'each' 'node' 'and' 'reset' 'pointers' 'to' 'zero' '
echo ' '' '' '' 'do' 'i' '=' '1,' 'mols+1' '
echo ' '' '' '' '' '' '' '' 'tree"("i")"'%'lnode' '=' '0
echo ' '' '' '' '' '' '' '' 'tree"("i")"'%'rnode' '=' '0
echo ' '' '' '' '' '' '' '' 'tree"("i")"'%'pnode' '=' '0
echo ' '' '' '' 'end' 'do' '
echo end' 'subroutine' 'initialize_binarytree
echo 
echo integer' 'function' 'findnextevent"("tree")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("node")",' 'dimension"("mols+1")",' 'intent"("inout")"' '::' 'tree' '!' 'binary' 'tree
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'nextnode
echo 
echo ' '' '' '' '!' 'start' 'the' 'search' 'for' 'the' 'minimum' 'time' 'with' 'the' 'root' 'node' '
echo ' '' '' '' 'nextnode' '=' 'rootnode
echo ' '' '' '' 'do
echo ' '' '' '' '' '' '' '' 'if' '"("tree"("nextnode")"'%'lnode' '==' '0")"' 'exit
echo ' '' '' '' '' '' '' '' 'nextnode' '=' 'tree"("nextnode")"'%'lnode
echo ' '' '' '' 'enddo' '
echo ' '' '' '' 'findnextevent' '=' 'nextnode
echo end' 'function' 'findnextevent
echo 
echo subroutine' 'addbranch"("tree,' 'newnode")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("node")",' 'dimension"("mols+1")",' 'intent"("inout")"' '::' 'tree' '!' 'binary' 'tree
echo ' '' '' '' 'integer,' 'intent"("in")"' '::' 'newnode' '!' 'node' 'to' 'be' 'added' 'to' 'tree
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("id")"' '::' 'a' '!' 'id' 'of' 'particle' 'corresponding' 'to' 'node
echo ' '' '' '' 'real"("kind=dbl")"' '::' 'tnew,' 'tcomp' '!' 'collision' 'time' 'of' 'new' 'and' 'compartison' 'nodes
echo ' '' '' '' 'integer' '::' 'ncomp' '!' 'current' 'insertion' 'node,' 'which' 'is' 'being' 'compared' 'to' 'the' 'new' 'node
echo ' '' '' '' 'logical' '::' 'nfound' '!' 'true' 'if' 'insert' 'position' 'of' 'new' 'branch' 'has' 'been' 'found,' 'else' 'false
echo 
echo ' '' '' '' 'if' '"("rootnode' '==' '0")"' 'then' '!' 'if' 'the' 'tree' 'is' 'empty
echo ' '' '' '' '' '' '' '' '!' 'establish' 'the' 'root' 'node' '
echo ' '' '' '' '' '' '' '' 'rootnode' '=' 'newnode' '
echo ' '' '' '' 'else' '!' 'the' 'tree' 'has' 'already' 'begun' '
echo ' '' '' '' '' '' '' '' 'if' '"(""("tree"("newnode")"'%'pnode' '/=' '0")"' '.or.' '"("newnode' '==' 'rootnode")"")"' 'then' '!' 'the' 'node' 'is' 'already' 'in' 'the' 'tree
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'remove' 'the' 'node' 'from' 'the' 'tree
echo ' '' '' '' '' '' '' '' '' '' '' '' 'call' 'delbranch' '"("tree,' 'newnode")"
echo ' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '!' 'save' 'the' 'time' 'of' 'the' 'next' 'event
echo ' '' '' '' '' '' '' '' 'if' '"("newnode' ''<'=' 'mols")"' 'then' '!' 'for' 'collision' 'events
echo ' '' '' '' '' '' '' '' '' '' '' '' 'a' '=' 'mol2id"("newnode")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'tnew' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'schedule'%'time
echo ' '' '' '' '' '' '' '' 'else' '!' 'for' 'ghost' 'events
echo ' '' '' '' '' '' '' '' '' '' '' '' 'tnew' '=' 'ghost_event'%'time
echo ' '' '' '' '' '' '' '' 'endif
echo 
echo ' '' '' '' '' '' '' '' '!' 'search' 'through' 'all' 'branches' 'to' 'find' 'the' 'proper' 'insert' 'position
echo ' '' '' '' '' '' '' '' 'ncomp' '=' 'rootnode
echo ' '' '' '' '' '' '' '' 'nfound' '=' '.false.
echo ' '' '' '' '' '' '' '' 'do' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("nfound")"' 'exit
echo ' '' '' '' '' '' '' '' '' '' '' '' '!' 'calculate' 'the' 'time' 'of' 'comparison' 'node\'s' 'event
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("ncomp' ''<'=' 'mols")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'a' '=' 'mol2id"("ncomp")"
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'tcomp' '=' 'square"("a'%'one")"'%'circle"("a'%'two")"'%'schedule'%'time
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'tcomp' '=' 'ghost_event'%'time
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo 
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("tnew' ''<'=' 'tcomp")"' 'then' '!' 'if' 'the' 'new' 'event' 'is' 'sooner' 'than' 'the' 'current' 'node' 'event
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'go' 'to' 'the' 'left' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("tree"("ncomp")"'%'lnode' '/=' '0")"' 'then' '!' 'if' 'the' 'current' 'node' 'has' 'a' 'left' 'node' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'ncomp' '=' 'tree"("ncomp")"'%'lnode' '!' 'compare' 'the' 'new' 'node' 'to' 'the' 'left' 'branch' 'of' 'the' 'current' 'node
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'else' '!' 'connect' 'the' 'new' 'node' 'to' 'the' 'left' 'of' 'current' 'node
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'tree"("ncomp")"'%'lnode' '=' 'newnode
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'nfound' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'exit
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else' '!' 'the' 'new' 'event' 'is' 'later' 'than' 'the' 'current' 'node' 'event
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '!' 'go' 'to' 'the' 'right' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("tree"("ncomp")"'%'rnode' '/=' '0")"' 'then' '!' 'if' 'the' 'current' 'node' 'has' 'a' 'right' 'node' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'ncomp' '=' 'tree"("ncomp")"'%'rnode' '!' 'compare' 'the' 'new' 'node' 'to' 'the' 'right' 'branch' 'of' 'the' 'current' 'node
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'else' '!' 'connect' 'the' 'new' 'node' 'to' 'the' 'right' 'of' 'current' 'node
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'tree"("ncomp")"'%'rnode' '=' 'newnode
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'nfound' '=' '.true.
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'exit
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'end' 'if
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'enddo' '
echo ' '' '' '' '' '' '' '' '!' 'link' 'the' 'new' 'node' 'to' 'the' 'previous' 'node
echo ' '' '' '' '' '' '' '' 'tree"("newnode")"'%'pnode' '=' 'ncomp
echo ' '' '' '' 'endif
echo end' 'subroutine' 'addbranch
echo 
echo subroutine' 'delbranch"("tree,' 'nonode")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("node")",' 'dimension"("mols+1")",' 'intent"("inout")"' '::' 'tree' '!' 'binary' 'tree
echo ' '' '' '' 'integer,' 'intent"("in")"' '::' 'nonode' '!' 'mold' 'id' 'of' 'particle' 'whose' 'node' 'is' 'being' 'deleted' 'from' 'tree
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'integer' '::' 'ns,' 'np' '!' 'pointers' 'used' 'for' 'relinking
echo 
echo ' '' '' '' '!' 'determine' 'the' 'relationship' 'of' 'the' 'deleted' 'node' 'to' 'other' 'nodes' 'in' 'the' 'tree' 'structure
echo ' '' '' '' '!' 'adapted' 'from' 'Smith' 'et' 'al.' 'MD' 'for' 'Polymeric' 'Fluids
echo ' '' '' '' 'if' '"("tree"("nonode")"'%'rnode' '==' '0")"' 'then
echo ' '' '' '' '' '' '' '' '!' 'CASE' 'I:' 'the' 'deleted' 'node' 'is' 'followed' 'on' 'the' 'right' 'branch' 'by' 'a' 'null' 'event
echo ' '' '' '' '' '' '' '' '!' 'SOL:' 'pnode' 'of' 'nonode' 'should' 'be' 'linked' 'to' 'lnode' 'of' 'nonode' '"("note' 'lnode' 'of' 'nonode' 'can' 'be
echo ' '' '' '' '' '' '' '' '!' 'either' 'a' 'null' 'event' 'or' 'another' 'branch")"
echo ' '' '' '' '' '' '' '' 'ns' '=' 'tree"("nonode")"'%'lnode
echo ' '' '' '' '' '' '' '' 'np' '=' 'tree"("nonode")"'%'pnode
echo ' '' '' '' '' '' '' '' 'if' '"("ns' '/=' '0")"' 'tree"("ns")"'%'pnode' '=' 'np
echo ' '' '' '' '' '' '' '' 'if' '"("np' '/=' '0")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("tree"("np")"'%'lnode' '==' 'nonode")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'tree"("np")"'%'lnode' '=' 'ns
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'tree"("np")"'%'rnode' '=' 'ns' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' 'else' 'if' '"("tree"("nonode")"'%'lnode' '==' '0")"' 'then' '!' '
echo ' '' '' '' '' '' '' '' '!' 'CASE' 'II:' 'the' 'deleted' 'node' 'contains' 'a' 'null' 'event' 'on' 'the' 'left' 'branch' '
echo ' '' '' '' '' '' '' '' '!' 'and' 'a' 'non-null' 'event' 'on' 'the' 'right' 'branch
echo ' '' '' '' '' '' '' '' '!' 'SOL:' 'pnode' 'of' 'nonode' 'should' 'be' 'linked' 'to' 'rnode' 'of' 'nonode
echo ' '' '' '' '' '' '' '' 'ns' '=' 'tree"("nonode")"'%'rnode
echo ' '' '' '' '' '' '' '' 'np' '=' 'tree"("nonode")"'%'pnode
echo ' '' '' '' '' '' '' '' 'tree"("ns")"'%'pnode' '=' 'np
echo ' '' '' '' '' '' '' '' 'if' '"("np' '/=' '0")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("tree"("np")"'%'lnode' '==' 'nonode")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'tree"("np")"'%'lnode' '=' 'ns
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'tree"("np")"'%'rnode' '=' 'ns' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' 'else' 'if' '"("tree"("tree"("nonode")"'%'rnode")"'%'lnode' '==' '0")"' 'then
echo ' '' '' '' '' '' '' '' '!' 'CASE' 'III:' 'the' 'deleted' 'node' 'contains' 'non-null' 'events' 'on' 'the' 'left' 'and' 'right' 'branches
echo ' '' '' '' '' '' '' '' '!' 'while' 'the' 'right' 'branch' 'contains' 'a' 'null' 'left' 'branch,' 'which' 'indicates' 'that' 'the' 'right' 'branch
echo ' '' '' '' '' '' '' '' '!' 'of' 'the' 'right' 'branch' 'is' 'the' 'smallest' 'event' 'time
echo ' '' '' '' '' '' '' '' '!' 'SOL:' 'Since' 'the' 'event' 'time' 'on' 'the' 'right' 'of' 'nonode' 'is' 'larger' 'than' 'the' 'event' 'time' 'on' 'the' 'left,
echo ' '' '' '' '' '' '' '' '!' 'rnode' 'of' 'nonode' 'is' 'designated' 'as' 'the' 'successor.' 'The' 'null' 'event' 'of' 'lnode' 'of' 'rnode' 'of' 'nonode
echo ' '' '' '' '' '' '' '' '!' 'is' 'replaced' 'with' 'lnode' 'of' 'nonode' '' '' '' '' '' '!' 'link' 'pnode' 'of' 'nonode' 'to' 'rnode' 'to' 'nonode
echo ' '' '' '' '' '' '' '' 'ns' '=' 'tree"("nonode")"'%'rnode
echo ' '' '' '' '' '' '' '' '!' 'link' 'the' 'left' 'branch' 'of' 'nonode' 'to' 'the' 'left' 'branch' 'of' 'the' 'successor' 'node' '"("null' 'event")"
echo ' '' '' '' '' '' '' '' 'np' '=' 'tree"("nonode")"'%'lnode' '
echo ' '' '' '' '' '' '' '' 'tree"("ns")"'%'lnode' '=' 'np' '
echo ' '' '' '' '' '' '' '' 'tree"("np")"'%'pnode' '=' 'ns' '
echo ' '' '' '' '' '' '' '' '!' 'link' 'the' 'successor' 'node' 'to' 'the' 'pointer' 'node' 'of' 'nonode
echo ' '' '' '' '' '' '' '' 'np' '=' 'tree"("nonode")"'%'pnode
echo ' '' '' '' '' '' '' '' 'tree"("ns")"'%'pnode' '=' 'np
echo ' '' '' '' '' '' '' '' 'if' '"("np' '/=' '0")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("tree"("np")"'%'lnode' '==' 'nonode")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'tree"("np")"'%'lnode' '=' 'ns
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'tree"("np")"'%'rnode' '=' 'ns' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' 'else' '
echo ' '' '' '' '' '' '' '' '!' 'CASE' 'IV:' 'last' 'case,' 'most' 'generic' 'solution' 'required.' 'The' 'right' 'branch' 'of' 'nonode' 'has
echo ' '' '' '' '' '' '' '' '!' 'a' 'non-null' 'left' 'branch
echo ' '' '' '' '' '' '' '' '!' 'SOL:' 'search' 'left' 'branch' 'of' 'right' 'branch' 'of' 'nonode' 'for' 'the' 'minimum' 'event' '
echo ' '' '' '' '' '' '' '' '!' 'find' 'the' 'node' 'whose' 'event' 'is' 'closest' 'to' 'nonode
echo ' '' '' '' '' '' '' '' 'ns' '=' 'tree"("tree"("nonode")"'%'rnode")"'%'lnode
echo ' '' '' '' '' '' '' '' 'do
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("tree"("ns")"'%'lnode' '==' '0")"' 'exit
echo ' '' '' '' '' '' '' '' '' '' '' '' 'ns' '=' 'tree"("ns")"'%'lnode
echo ' '' '' '' '' '' '' '' 'enddo' '
echo ' '' '' '' '' '' '' '' '!' 'replace' 'the' 'successor' 'node' 'with' 'the' 'successor' 'node\'s' 'right' 'branch
echo ' '' '' '' '' '' '' '' 'np' '=' 'tree"("ns")"'%'pnode' '
echo ' '' '' '' '' '' '' '' 'tree"("np")"'%'lnode' '=' 'tree"("ns")"'%'rnode' '
echo ' '' '' '' '' '' '' '' 'if' '"("tree"("ns")"'%'rnode' '/=' '0")"' 'tree"("tree"("ns")"'%'rnode")"'%'pnode' '=' 'np' '
echo ' '' '' '' '' '' '' '' '!' 'replace' 'nonode' 'with' 'the' 'successor' 'node
echo ' '' '' '' '' '' '' '' '!' 'link' 'the' 'right' 'branch' 'of' 'nonode' 'to' 'the' 'right' 'branch' 'of' 'the' 'successor' 'node
echo ' '' '' '' '' '' '' '' 'np' '=' 'tree"("nonode")"'%'rnode' '
echo ' '' '' '' '' '' '' '' 'tree"("np")"'%'pnode' '=' 'ns' '
echo ' '' '' '' '' '' '' '' 'tree"("ns")"'%'rnode' '=' 'np
echo ' '' '' '' '' '' '' '' '!' 'link' 'the' 'left' 'branch' 'of' 'nonode' 'to' 'the' 'left' 'branch' 'of' 'the' 'successor' 'node' '"("null' 'event")"
echo ' '' '' '' '' '' '' '' 'np' '=' 'tree"("nonode")"'%'lnode' '
echo ' '' '' '' '' '' '' '' 'tree"("np")"'%'pnode' '=' 'ns' '
echo ' '' '' '' '' '' '' '' 'tree"("ns")"'%'lnode' '=' 'np' '
echo ' '' '' '' '' '' '' '' '!' 'link' 'the' 'successor' 'node' 'to' 'nonode\'s' 'predossesor' 'node' '
echo ' '' '' '' '' '' '' '' 'np' '=' 'tree"("nonode")"'%'pnode
echo ' '' '' '' '' '' '' '' 'tree"("ns")"'%'pnode' '=' 'np
echo ' '' '' '' '' '' '' '' 'if' '"("np' '/=' '0")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'if' '"("tree"("np")"'%'lnode' '==' 'nonode")"' 'then' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'tree"("np")"'%'lnode' '=' 'ns
echo ' '' '' '' '' '' '' '' '' '' '' '' 'else
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'tree"("np")"'%'rnode' '=' 'ns' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' '' '' '' '' 'endif
echo ' '' '' '' 'endif
echo 
echo ' '' '' '' 'if' '"("nonode' '==' 'rootnode")"' 'then' '!' 'if' 'nonode' 'is' 'the' 'rootnode
echo ' '' '' '' '' '' '' '' '!' 'reset' 'the' 'rootnode' 'as' 'the' 'successor' 'node
echo ' '' '' '' '' '' '' '' 'rootnode' '=' 'ns' '
echo ' '' '' '' 'endif
echo 
echo ' '' '' '' '!' 'reset' 'nonode
echo ' '' '' '' 'tree"("nonode")"'%'pnode' '=' '0
echo ' '' '' '' 'tree"("nonode")"'%'rnode' '=' '0
echo ' '' '' '' 'tree"("nonode")"'%'lnode' '=' '0' '
echo end' 'subroutine' 'delbranch
echo 
echo !' '//' 'false' 'positioning' 'method' '//
echo 
echo subroutine' 'update_positions"("")"
echo ' '' '' '' 'implicit' 'none
echo ' '' '' '' '!' ''*''*'' 'calling' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '!' ''*''*'' 'local' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' 'type"("position")",' 'dimension"("mols")"' '::' 'pos' '!' 'real' 'position' 'of' 'each' 'particle
echo ' '' '' '' 'integer' '::' 'i,' 'm,' 'q' '!' 'indexing' 'parameters' '
echo 
echo ' '' '' '' '!' 'calculate' 'the' 'real' 'position' 'of' 'each' 'particle
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube' '
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'do' 'q' '=' '1,' 'ndim' '
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'pos"("id2mol"("i,m")"")"'%'r"("q")"' '=' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("q")"' '+' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("q")"' ''*'' 'tsl
echo ' '' '' '' '' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' '' '' '' '' '' '' '' '' 'call' 'apply_periodic_boundaries' '"("pos"("id2mol"("i,m")"")"")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'fpos' '=' 'pos"("id2mol"("i,m")"")"
echo ' '' '' '' '' '' '' '' 'enddo
echo ' '' '' '' 'enddo
echo ' '' '' '' '!' 'reset' 'the' 'update' 'time
echo ' '' '' '' 'tsl' '=' '0.
echo ' '' '' '' 'tl' '=' 'timenow
echo end' 'subroutine' 'update_positions
echo 
echo end' 'module' 'polarizedsquaremodule
echo 
echo 
echo program' 'polarizedsquare' '
echo use' 'polarizedsquaremodule
echo implicit' 'none' '
echo 
echo !' ''*''*'' 'program' 'variables' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo integer' '::' 'i,' 'm' '!' 'indexing' 'parameters
echo type' '"("event")"' '::' 'next_event' '!' 'length' 'of' 'step' 'forward' 'in' 'time' '
echo type"("id")"' '::' 'a,' 'b' '!' 'event' 'partners
echo integer' '::' 'movno' '=' '0' '!' 'used' 'for' 'movie' 'making
echo 
echo call' 'initialize_system' '"("")"
echo call' 'complete_reschedule' '"("")"
echo 
echo if' '"("debug' ''>'=' '2")"' 'then' '
echo ' '' '' '' 'do' 'i' '=' '1,' 'cube' '
echo ' '' '' '' '' '' '' '' 'do' 'm' '=' '1,' 'mer' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'write"("simiounit,'*'")"' '\'' '\'' '
echo ' '' '' '' '' '' '' '' '' '' '' '' 'write"("simiounit,' '\'"("\"Circle' '\",' 'I3,' '\"' 'of' 'square' '\",' 'I3")"\'")"' 'm,' 'i
echo ' '' '' '' '' '' '' '' '' '' '' '' 'write"("simiounit,\""("\'POSITION:' '\',2"("f6.2")"")"\"")"' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("1")",' 'square"("i")"'%'circle"("m")"'%'fpos'%'r"("2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'write"("simiounit,\""("\'VELOCITY:' '\',2"("f6.2")"")"\"")"' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("1")",' 'square"("i")"'%'circle"("m")"'%'vel'%'v"("2")"
echo ' '' '' '' '' '' '' '' '' '' '' '' 'write"("simiounit,\""("\'CHARGE' ':' '\',' 'I3")"\"")"' 'square"("i")"'%'circle"("m")"'%'pol
echo ' '' '' '' '' '' '' '' '' '' '' '' 'write"("simiounit,\""("\'Event' 'with' 'circle' '\',' 'I3,\'' 'of' 'square' '\',' 'I4,\'' 'in' '\',F8.5,\'' 'seconds' '"("collision' 'type' '\',' 'I2,\'")".\'")"\"")"' ''&'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'schedule'%'partner'%'two,' 'square"("i")"'%'circle"("m")"'%'schedule'%'partner'%'one,' ''&'
echo ' '' '' '' '' '' '' '' '' '' '' '' '' '' '' '' 'square"("i")"'%'circle"("m")"'%'schedule'%'time,' 'square"("i")"'%'circle"("m")"'%'schedule'%'type' '
echo ' '' '' '' '' '' '' '' 'end' 'do' '
echo ' '' '' '' 'end' 'do' '
echo end' 'if' '
echo 
echo single_step:' 'do' '
echo 
echo ' '' '' '' 'if' '"("nbrnow")"' 'then' '
echo ' '' '' '' '' '' '' '' 'call' 'build_neighborlist
echo ' '' '' '' 'endif
echo 
echo ' '' '' '' '!' 'find' 'next' '/' 'soonest' 'occuring' 'event' '
echo ' '' '' '' '!' 'integrate' 'the' 'system' 'forward' 'in' 'time' '
echo ' '' '' '' 'call' 'forward' '"("next_event,' 'a,' 'b")"
echo 
echo ' '' '' '' '!' 'process' 'next' 'event' '
echo ' '' '' '' 'if' '"("a'%'one' '==' '"("cube' '+' '1")"")"' 'then' '!' 'ghost' 'collision' 'event' '
echo ' '' '' '' '' '' '' '' 'call' 'ghost_collision' '"("tempset")"
echo ' '' '' '' '' '' '' '' 'call' 'ghost_reschedule' '"("ghost_event'%'partner'%'one")"' '!' 'update' 'calander' 'for' 'each' 'circle' 'in' '
echo ' '' '' '' '' '' '' '' 'ghost_event' '=' 'predict_ghost"("")"' '!' 'schedule' 'next' 'ghost' 'collision
echo ' '' '' '' '' '' '' '' 'call' 'addbranch' '"("eventTree,' 'mols+1")"
echo ' '' '' '' 'else' '!' 'collision' 'event' '
echo ' '' '' '' '' '' '' '' 'call' 'collide' '"("a,' 'b,' 'next_event,' 'pv'%'value")"
echo ' '' '' '' '' '' '' '' 'call' 'collision_reschedule' '"("a,' 'b")"
echo ' '' '' '' '' '' '' '' 'call' 'update_orderlist"("a,' 'b")"
echo ' '' '' '' '' '' '' '' '!' ''*''*'' 'Compressibility' 'Factor' ''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*''*'
echo ' '' '' '' '' '' '' '' 'call' 'accumulate_properties' '"("pv,' '2")"
echo ' '' '' '' 'endif
echo 
echo ' '' '' '' '!' 'completely' 'reschedule' 'calander
echo ' '' '' '' 'if' '"("mod"("n_events,' 'event_reschedule")"' '==' '0")"' 'then' '
echo ' '' '' '' '' '' '' '' 'call' 'complete_reschedule' '"("")"
echo ' '' '' '' '' '' '' '' 'if' '"("check_boundaries"("")"")"' 'call' 'restart' '"("")"
echo ' '' '' '' 'end' 'if' '
echo 
echo ' '' '' '' '!' 'property' 'calculations
echo ' '' '' '' 'if' '"("mod"("n_events,' 'propfreq")"' '==' '0")"' 'then' '
echo ' '' '' '' '' '' '' '' 'call' 'calculate_poperties' '"("")"
echo ' '' '' '' 'end' 'if' '
echo ' '' '' '' '!' 'report' 'and' 'reset' 'properties' 'to' 'user' 'information
echo ' '' '' '' 'if' '"(""("mod"("n_events,' 'event_average")"' '==' '0")"' '.and.' '"("n_events' '/=' '0")"")"' 'then' '
echo ' '' '' '' '' '' '' '' 'call' 'report_properties' '"("")"
echo ' '' '' '' '' '' '' '' 'call' 'save"("")"
echo ' '' '' '' 'end' 'if' '
echo 
echo ' '' '' '' '!' 'take' 'snap' 'shot' 'for' 'movie' 'generation' 'as' 'spheres
echo ' '' '' '' 'if' '"(""(""("moviesph' '==' '1")"' '.or.' '"("moviesqu' '==' '1")"")"' '.and.' '"("real"("movno")"' ''<'' '"("timenow' '/' 'movfreq")"")"")"' 'then' '
echo ' '' '' '' '' '' '' '' 'if' '"("moviesph' '==' '1")"' 'call' 'record_position_circles' '"("")"
echo ' '' '' '' '' '' '' '' 'if' '"("moviesqu' '==' '1")"' 'call' 'record_position_squares' '"("")"
echo ' '' '' '' '' '' '' '' 'movno' '=' 'movno' '+' '1
echo ' '' '' '' 'end' 'if
echo 
echo ' '' '' '' 'if' '"("n_events' ''>'=' '"("event_equilibriate' '+' 'event_equilibrium")"")"' 'then
echo ' '' '' '' '' '' '' '' 'call' 'close_files"("")"' '
echo ' '' '' '' '' '' '' '' 'anneal' '=' 'anneal' '+' '1' '!' 'incriment' 'the' 'integer' 'used' 'to' 'track' 'the' 'number' 'of' 'simulations' 'which' 'have' 'been' 'performed
echo ' '' '' '' '' '' '' '' 'call' 'adjust_temperature' '"("tempset")"' '!' 'set' 'the' 'temperature' 'of' 'the' 'current' 'simulation' 'based' 'on' 'the' 'temperature' 'of' 'the' 'previous' 'simulation
echo ' '' '' '' '' '' '' '' 'call' 'update_positions"("")"
echo ' '' '' '' '' '' '' '' 'call' 'save' '"("")"' '!' 'save' 'the' 'final' 'state' 'of' 'the' 'simulation' '
echo ' '' '' '' '' '' '' '' 'call' 'exit' '"("")"' '!' 'end' 'the' 'simulation' '
echo ' '' '' '' 'end' 'if' '
echo 
echo end' 'do' 'single_step
echo 
echo end' 'program' 'polarizedsquare
echo 
echo 
