import md5
import struct
import operator

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

def validate(email, key):
    email_hash_string = get_email_hash(email)

    digits = []
    for c in key:
        try:
            digits.append(int(c))
        except ValueError:
            return False, 'must be numerical'

    if not key.startswith(email_hash_string):
        return False, 'must start with the email hash'

    if len(digits) != 24:
        return False, 'must be 24 digits long'

    # sum of digits at positions 10-14
    s = sum(digits[10:15])
    if s != 21:
        return False, 'must contain a predetermined sum'

    # product of digits at positions 15-20
    p = reduce(operator.mul, digits[15:20], 1)
    if p != 480:
        return False, 'must contain a predetermined product'

    # accumulate digits at even indexes
    acc = 0
    for i in xrange(0, len(digits), 2):
        acc += digits[i]
    if acc % 16 != 3:
        return False, 'sum of even index digits % 16 must be == 3'

    # accumulate digits at odd indexes
    acc = 0
    for i in xrange(1, len(digits), 2):
        acc += digits[i]
    if acc % 16 != 7:
        return False, 'sum of odd index digits % 16 must be == 7'

    return True, ''


def main():
    valid, msg = validate('a@b.com', '389444254963840534810840')
    if valid:
        print 'valid!'
    else:
        print 'nope: ' + msg


if __name__ == '__main__':
    main()
