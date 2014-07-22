/*
 * interfaceHandler.hpp
 *
 *  Created on: 22 lip 2014
 *  Author: Filip Ryborz
 *  Website: simply-embedded.blogspot.com
 */

#ifndef INTERFACEHANDLER_HPP_
#define INTERFACEHANDLER_HPP_

#include "serialPort.hpp"

class cInterfaceHandler
{
private:
	cSerialPort serialPort;
public:
	cInterfaceHandler();

	int getFrame();
	void sendFrame(int f);
};



#endif /* INTERFACEHANDLER_HPP_ */
