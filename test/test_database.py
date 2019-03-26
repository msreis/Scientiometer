import unittest

import mysql.connector

class TestDB(unittest.TestCase):
    def test_connection(self):
        """
        Test the connection to mysql server
        """

        mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            passwd="example"
        )

        self.assertTrue(mydb.is_connected())


if __name__ == '__main__':
    unittest.main()