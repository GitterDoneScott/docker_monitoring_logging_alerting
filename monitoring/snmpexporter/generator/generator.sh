docker run --rm -v "$PWD/mibs:/root/.snmp/mibs" \
 -v "$PWD/generator.yml:/root/go/src/github.com/prometheus/snmp_exporter/generator/generator.yml" \
 -v "$PWD/snmp.yml:/root/go/src/github.com/prometheus/snmp_exporter/generator/snmp.yml" aabbate/secg
