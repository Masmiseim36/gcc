// { dg-do run { target c++11 } }
// { dg-require-cstdint "" }
//
// 2008-11-24  Edward M. Smith-Rowland <3dw4rd@verizon.net>
//
// Copyright (C) 2008-2025 Free Software Foundation, Inc.
//
// This file is part of the GNU ISO C++ Library.  This library is free
// software; you can redistribute it and/or modify it under the
// terms of the GNU General Public License as published by the
// Free Software Foundation; either version 3, or (at your option)
// any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along
// with this library; see the file COPYING3.  If not see
// <http://www.gnu.org/licenses/>.

// C++11
// 26.5.8.5.2 Class template lognormal_distribution [rand.dist.norm.lognormal]
// 26.5.1.6 random number distribution requirements [rand.req.dist]

#include <random>
#include <testsuite_hooks.h>
#include <testsuite_common_types.h>

void
test01()
{
  std::lognormal_distribution<> u;
  VERIFY( u.m() == 0.0 );
  VERIFY( u.s() == 1.0 );
  typedef std::lognormal_distribution<>::result_type result_type;
  VERIFY( u.min() == 0.0 );
  VERIFY( u.max() == std::numeric_limits<result_type>::max() );
}

void
test02()
{
  __gnu_test::implicitly_default_constructible test;
  test.operator()<std::lognormal_distribution<>>();
  test.operator()<std::lognormal_distribution<>::param_type>();
}

int
main()
{
  test01();
  test02();
}
