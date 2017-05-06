import md5
import struct
from z3 import *


def get_email_hash(email):
    """
    md5 the email address, keeps the low 32 bits of the digest
    returns the stringified hash
    """
    m = md5.new()
    m.update(email)
    digest = m.digest()
    email_hash = struct.unpack('I', digest[0:4])[0]
    return "%u" % email_hash


def keygen(email):
    num_digits = 24
    solver = Solver()
    d = Ints(' '.join(["d%d" %i for i in range(num_digits)]))

    for i in range(num_digits):
        solver.add(d[i] >= 0, d[i] <= 9)

    email_hash = get_email_hash(email)
    for i in range(len(email_hash)):
        solver.add(d[i] == int(email_hash[i]))

    solver.add(d[10] + d[11] + d[12] + d[13] + d[14] == 21)
    solver.add(d[15] * d[16] * d[17] * d[18] * d[19] == 480)

    if solver.check() == sat:
        model = solver.model()
        for i in range(20):
            solver.add(d[i] == model.eval(d[i]))
    else:
        print 'no valid code found :('

    digits_sum_even = reduce(lambda a,b: a+b, d[0:len(d):2])
    solver.add(digits_sum_even % 16 == 3)

    digits_sum_odd = reduce(lambda a,b: a+b, d[1:len(d):2])
    solver.add(digits_sum_odd % 16 == 7)

    if solver.check() == sat:
        model = solver.model()
        print 'email: ' + email
        print 'code : ' + ''.join([str(model[d[i]]) for i in range(num_digits)])
        print
    else:
        print 'no valid code found :('

if __name__ == '__main__':
    keygen('a@b.com')
    keygen('example@example.com')
    keygen('someuser@somedomain.net')
