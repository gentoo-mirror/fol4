# b-overlay
cat > /etc/layman/overlays/b-overlay.xml << EOF
'<repositories version="1.0">
  <repo quality="experimental" status="unofficial">
    <name>b-overlay</name>
    <description lang="en">Collection of custom ebuilds</description>
    <homepage>https://github.com/madsl/b-overlay</homepage>
    <owner type="person">
      <email>mads@ab3.no</email>
      <name>Mads</name>
    </owner>
    <source type="git">git://github.com/madsl/b-overlay.git</source>
  </repo>
</repositories>'
EOF
