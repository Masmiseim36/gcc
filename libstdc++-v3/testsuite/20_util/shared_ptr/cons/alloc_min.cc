// { dg-do compile { target c++11 } }

// Copyright (C) 2011-2025 Free Software Foundation, Inc.
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

// 20.7.2.2 Class template shared_ptr [util.smartptr.shared]

#include <memory>
#include <testsuite_allocator.h>

struct X { };

// 20.7.2.2.1 shared_ptr constructors [util.smartptr.shared.const]

// test shared_ptr with minimal allocator

__gnu_test::SimpleAllocator<X> alloc;
auto deleter = [](X* p) { delete p; };
std::shared_ptr<X> p(new X, deleter, alloc);

