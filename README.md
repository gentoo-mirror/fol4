fol4 overlay
------------
Contains mostly random multilib ebuilds.

* Adobe AIR 2.6 with multilib support
* qtserialport-5.3.1 with qt4 multilib support (this needs eclass files from Gentoo qt-overlay)
* audacious{,-plugins}-9999 with gtk2 support and qt5 use flag

<pre>cat &gt; /etc/layman/overlays/fol4.xml &lt;&lt; EOF
&lt;repositories version="1.0"&gt;
  &lt;repo quality="experimental" status="unofficial"&gt;
    &lt;name&gt;fol4&lt;/name&gt;
    &lt;description lang="en"&gt;Collection of custom ebuilds&lt;/description&gt;
    &lt;homepage&gt;https://github.com/madsl/fol4&lt;/homepage&gt;
    &lt;owner type="person"&gt;
      &lt;email&gt;mads@ab3.no&lt;/email&gt;
      &lt;name&gt;Mads&lt;/name&gt;
    &lt;/owner&gt;
    &lt;source type="git"&gt;git://github.com/madsl/fol4.git&lt;/source&gt;
  &lt;/repo&gt;
&lt;/repositories&gt;
EOF</pre>
