#!/usr/bin/env python
import ldap
import sys

# UIUC specific options
ldap_server = "ldap://ldap.uiuc.edu"
base_dn = "ou=people,dc=uiuc,dc=edu"
scope = ldap.SCOPE_SUBTREE
search_fields = ['givenname', 'sn', 'cn', 'uid']
answer_fields = ['displayName', 'eduPersonPrimaryAffiliation', 'mail', 'o',
        'uiucEduStudentDepartmentName', 'uiucEduStudentLevelName',
        'uiucEduStudentMajorName']
response_fields = ['mail', 'displayName', 'o']

def ldap_search(search):
    l = ldap.initialize(ldap_server)
    res = []
    for field in search_fields:
        field = '%s=%s*' % (field, search)
        items = l.search_s(base_dn, scope, field, answer_fields)
        res += [ i for i in items if i not in res ]

    print "LDAP Query: Found %s" % (len(res))
    for r in res:
        try:
            print ''.join([ '%s\t' % r[1][f][0] for f in response_fields ])
        except:
            pass


def main(argv = None):
    if argv is None:
        argv = sys.argv
    try:
        ldap_search(argv[1])
    except:
        pass


if __name__ == "__main__":
    main()

