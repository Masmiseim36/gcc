// 2001-05-21 Benjamin Kosnik  <bkoz@redhat.com>

// Copyright (C) 2001-2025 Free Software Foundation, Inc.
//
// This file is part of the GNU ISO C++ Library.  This library is free
// software; you can redistribute it and/or modify it under the
// terms of the GNU General Public License as published by the
// Free Software Foundation; either version 3, or (at your option)
// any later version.

// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License along
// with this library; see the file COPYING3.  If not see
// <http://www.gnu.org/licenses/>.

// 27.8.1.4 Overridden virtual functions

#include <fstream>
#include <testsuite_hooks.h>
#include <testsuite_io.h>

const char name_01[] = "tmp_sungetc_2out.tst"; // empty file, need to create

// Test overloaded virtual functions.
void test01() 
{
  using namespace std;
  using namespace __gnu_test;
  typedef std::filebuf::int_type 	int_type;
  typedef filebuf::traits_type 		traits_type;

  int_type 			c1, c2;

  // int_type sungetc()
  // if in_cur not avail, return pbackfail(), else decrement and
  // return to_int_type(*gptr())

  // out
  {
    constraint_filebuf fb_01; // out
    fb_01.pubsetbuf(0, 0);
    fb_01.open(name_01, ios::out | ios::trunc);    
    VERIFY( fb_01.unbuffered() );
    VERIFY( !fb_01.read_position() );
    c1 = fb_01.sgetc();
    VERIFY( c1 == traits_type::eof() );
    c2 = fb_01.sungetc();
    VERIFY( c2 == traits_type::eof() );
    fb_01.sbumpc();
    c1 = fb_01.sbumpc();
    c2 = fb_01.sungetc();
    VERIFY( c1 == c2 );
    VERIFY( fb_01.unbuffered() );
    VERIFY( !fb_01.read_position() );
  }
}

int main() 
{
  test01();
  return 0;
}
