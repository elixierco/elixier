{{- define "nifi.authorizers" -}}
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<authorizers>

    {{ if .Values.global.ldap.enabled }}
    <userGroupProvider>
        <identifier>ldap-user-group-provider</identifier>
        <class>org.apache.nifi.ldap.tenants.LdapUserGroupProvider</class>
        <property name="Authentication Strategy">SIMPLE</property>

        <property name="Manager DN">{{ .Values.global.ldap.bindDN }}</property>
        <property name="Manager Password">{{ .Values.global.ldap.bindPassword }}</property>

        <property name="TLS - Keystore">/etc/keystore/keystore</property>
        <property name="TLS - Keystore Password">{{ .Values.global.keystore.password }}</property>
        <property name="TLS - Keystore Type">{{ .Values.global.keystore.type }}</property>
        <property name="TLS - Truststore">/etc/keystore/truststore</property>
        <property name="TLS - Truststore Password">{{ .Values.global.truststore.password }}</property>
        <property name="TLS - Truststore Type">{{ .Values.global.truststore.type }}</property>
        <property name="TLS - Client Auth">NONE</property>
        <property name="TLS - Protocol">{{ .Values.global.ldap.tlsProtocol | default "TLS"}}</property>
        <property name="TLS - Shutdown Gracefully">false</property>
        
        <property name="Referral Strategy">FOLLOW</property>
        <property name="Connect Timeout">60 secs</property>
        <property name="Read Timeout">60 secs</property>

        <property name="Url">{{ .Values.global.ldap.url }}</property>

        <property name="Page Size">300</property>
        <property name="Sync Interval">10 mins</property>

        <property name="User Search Base">{{ .Values.global.ldap.userBaseDN }}</property>
        <property name="User Search Scope">{{ .Values.global.ldap.userSearchScope | default "SUBTREE" }}</property>
        <property name="User Search Filter">{{ .Values.global.ldap.userSearchFilter }}</property>
        <property name="User Identity Attribute">{{ .Values.global.ldap.usernameAttr }}</property>
        <property name="User Object Class">{{ .Values.global.ldap.userObjectClass }}</property>
        <property name="User Group Name Attribute">{{ .Values.global.ldap.groupAttr }}</property>
        <property name="Group Search Base">{{ .Values.global.ldap.groupBaseDN }}</property>

        <property name="Group Object Class">{{ .Values.global.ldap.groupObjectClass }}</property>
        <property name="Group Search Scope">{{ .Values.global.ldap.groupSearchScope | default "SUBTREE" }}</property>
        <property name="Group Search Filter">{{ .Values.global.ldap.groupSearchFilter }}</property>

    </userGroupProvider>
    {{ else }}
    <userGroupProvider>
        <identifier>file-user-group-provider</identifier>
        <class>org.apache.nifi.authorization.FileUserGroupProvider</class>
        <property name="Users File">./conf/users.xml</property>
        <property name="Legacy Authorized Users File"></property>
        <property name="Initial User Identity 1">
            {{- .Values.initialAdminIdentity | default "" -}}
        </property>
    </userGroupProvider>
    {{ end }}



    <accessPolicyProvider>
        <identifier>file-access-policy-provider</identifier>
        <class>org.apache.nifi.authorization.FileAccessPolicyProvider</class>

        {{ if .Values.global.ldap.enabled }}
        <property name="User Group Provider">ldap-user-group-provider</property>
        {{ else }}
        <property name="User Group Provider">file-user-group-provider</property>
        {{ end }}
        <property name="Authorizations File">/var/lib/nifi/authorizations.xml</property>
        <property name="Initial Admin Identity">
            {{- .Values.initialAdminIdentity | default "" -}}
        </property>
        <property name="Legacy Authorized Users File"></property>
        <property name="Node Identity 1"></property>
        <property name="Node Group"></property>
    </accessPolicyProvider>

    <authorizer>
        <identifier>managed-authorizer</identifier>
        <class>org.apache.nifi.authorization.StandardManagedAuthorizer</class>
        <property name="Access Policy Provider">file-access-policy-provider</property>
    </authorizer>

</authorizers>
{{- end }}
