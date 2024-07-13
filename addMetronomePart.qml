import QtQuick 2.0
import MuseScore 3.0

MuseScore {
   menuPath: "Plugins.Add Metronome Part"
   description: "Add metronome part"
   version: "0.1"
   requiresScore: true
   id: addMetronomePart
   //4.4 title: "Add Metronome Part"

   Component.onCompleted : {
      if (mscoreMajorVersion >= 4) {
          addMetronomePart.title = "Add Metronome Part";
      }
   }   

   onRun: {
      console.log("...")
            
      curScore.appendPart("wood-blocks")
      var idx = curScore.nstaves-1
      
      curScore.parts[idx].isMetro = true
      
      var c = curScore.newCursor()
      c.rewind(0)
      c.staffIdx = idx
      c.voice = 0
      if( c.measure.timesigActual.str != c.measure.timesigNominal.str )
         c.nextMeasure()
      do{
         c.setDuration( 1, c.measure.timesigActual.denominator )
         for( var i=1; i <= c.measure.timesigActual.numerator; i++ )
            c.addNote( i==1 ? 76 : 77, false )
      }while( c.prev() && c.nextMeasure() )
      
      quit()
   }
}

