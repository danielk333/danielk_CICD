import unittest

class A(unittest.TestCase):

    def test_A_init(self):
        import example
        a = example.A()

    def test_always_ok(self):
        assert 0==0
