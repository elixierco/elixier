{{- define "nifi.authorizers" -}}
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<authorizers>

    <userGroupProvider>
        <identifier>file-user-group-provider</identifier>
        <class>org.apache.nifi.authorization.FileUserGroupProvider</class>
        <property name="Users File">./conf/users.xml</property>
        <property name="Legacy Authorized Users File"></property>
        <property name="Initial User Identity 1">
        {{- if .Values.global.oidc.enabled -}}
            {{ .Values.initial_admin_identity | default "" }}
        {{- end -}}
        </property>
    </userGroupProvider>

    <accessPolicyProvider>
        <identifier>file-access-policy-provider</identifier>
        <class>org.apache.nifi.authorization.FileAccessPolicyProvider</class>
        <property name="User Group Provider">file-user-group-provider</property>
        <property name="Authorizations File">./conf/authorizations.xml</property>
        <property name="Initial Admin Identity">
        {{- if .Values.global.oidc.enabled -}}
            {{ .Values.initial_admin_identity | default "" }}
        {{- end -}}
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

    <authorizer>
        <identifier>single-user-authorizer</identifier>
        <class>org.apache.nifi.authorization.single.user.SingleUserAuthorizer</class>
    </authorizer>
</authorizers>
{{- end }}
