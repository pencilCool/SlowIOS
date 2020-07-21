//
//  MoreOCLoadClass.cpp
//  MoreLoad
//
//  Created by pencilCool on 2020/7/22.
//  Copyright © 2020 pencilCool. All rights reserved.
//

#include "MoreOCLoadClass.hpp"
#include <iostream>

template<unsigned n>
struct Factorial{
    enum{ value = n * Factorial<n-1>::value };
};
template<>
struct Factorial<0>{
    enum{ value = 1 };
};


__attribute__((constructor))
static void load_in_cpp(void) {
    std::cout << "\nhello\n";
    std::cout<<Factorial<5>::value << "\n";
}
