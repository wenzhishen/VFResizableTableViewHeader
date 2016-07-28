//
//  Marcoes.h
//  VFResizableTableViewHeaderDemo
//
//  Created by HS on 7/28/16.
//  Copyright © 2016 Vincent. All rights reserved.
//

#ifndef Marcoes_h
#define Marcoes_h

#ifndef DebugLog
#if DEBUG
#define DebugLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
#else
#define DebugLog(fmt, ...)
#endif
#endif

#endif /* Marcoes_h */
