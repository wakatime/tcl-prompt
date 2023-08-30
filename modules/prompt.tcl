package provide prompt 0.0.1
namespace eval ::prompt {}

package require tclreadline
package require term::ansi::code::attr

proc ::prompt::get_icon {} {
  global argv0
  array set platforms {
    unknown ?
    docker 
    android 
    arch 
    linux 
    macos 
    windows 
    centos 
    debian 
    ubuntu 
    gentoo 
    nixos 
  }
  catch {set init [exec ps -p1 -ocmd=]}
  if {$init == {/sbin/docker-init}} {
    set platform docker
  } elseif {[array get env(PREFIX)] == {/data/data/com.termux/files/usr}} {
    set platform android
  } elseif {[string match *.exe $argv0]} {
    set platform windows
  } elseif {[exec uname -s] == {Linux}} {
    set platform linux
    catch {set platform [string tolower [exec lsb_release -i | cut -f2]]}
  } elseif {[exec uname -s] == {Darwin}} {
    set platform darwin
  } else {
    set platform unknown
  }
  return $platforms($platform)
}
set ::prompt::icon [::prompt::get_icon]

proc ::prompt::get_version {} {
  global argv0
  global tcl_version

  set exe [file tail $argv0]
  return " $exe $tcl_version"
}
set ::prompt::version [::prompt::get_version]

proc ::prompt::get_cwd {} {
  global env
  set pwd [pwd]

  if {![info exists env(HOME)]} {
    return $pwd
  }
  set normalized_home [file normalize $env(HOME)]
  if {[string first $normalized_home $pwd] == 0} {
    set pwd [string replace $pwd 0 [expr {[string length $normalized_home] - 1}] ~]
  }
  return " $pwd"
}

proc ::prompt::get_time {} {
  set date [exec date +%T]
  return " $date"
}

proc ::prompt::tput {args} {
  set out "\x1b\["
  set no_fg_bg 0
  foreach value $args {
    if {$value == {setaf}} {
      set no_fg_bg 1
      continue
    } elseif {$value == {setab}} {
      set no_fg_bg 2
      continue
    }
    if {$no_fg_bg == 1} {
      set out "${out}[eval term::ansi::code::attr::fg$value];"
    } elseif {$no_fg_bg == 2} {
      set out "${out}[eval term::ansi::code::attr::bg$value];"
    } elseif {$no_fg_bg == 0} {
      set out "${out}[eval term::ansi::code::attr::$value];"
    }
    set no_fg_bg 0
  }
  if {[string index $out end] == {;}} {
    set out [string replace $out end end {}]
  }
  set out "${out}m"
  return $out
}

proc ::prompt::get_ps1 {args} {
  if {[llength $args] == 0} {
    lappend args [list black white $::prompt::icon]
    lappend args [list black yellow $::prompt::version]
    lappend args {black white ::prompt::get_time}
    lappend args {white blue ::prompt::get_cwd}
  }
  set prompt_string "\n% "
  set sep 
  set format { %s }
  set arg0 [lindex $args 0]
  if {[llength $arg0] == 1} {
    set prompt_string $arg0
    set args [lrange $args 1 end]
  }
  set ps1 {}
  set last_bg {}
  foreach value $args {
    if {[llength $value] == 1} {
      if {[string first %s $value] >= 0} {
        set format $value
      } else {
        set sep $value
      }
      continue
    }
    set fg [lindex $value 0]
    set bg [lindex $value 1]
    set text [lindex $value 2]
    if {[llength [info command $text]] > 0} {
      set text [eval $text]
    }
    set text [format $format $text]
    if {[llength $last_bg] > 0} {
      set ps1 "$ps1[::prompt::tput setaf $last_bg setab $bg]$sep[::prompt::tput setaf $fg]$text"
    } else {
      set ps1 "$ps1[::prompt::tput setaf $fg setab $bg]$text"
    }
    set last_bg $bg;
  }
  set ps1 "$ps1[::prompt::tput reset setaf $last_bg]$sep[::prompt::tput reset]$prompt_string"
  return $ps1
}

proc ::tclreadline::prompt1 {} {
  return [::prompt::get_ps1]
}
