/**
  ******************************************************************************
  * File Name          : main.c
  * Description        : Main program body
  ******************************************************************************
  *
  * COPYRIGHT(c) 2016 STMicroelectronics
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */
/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "stm32f3xx_hal.h"
#include "i2c.h"
#include "spi.h"
#include "gpio.h"

/* USER CODE BEGIN Includes */
#include "stdio.h"
#include "stm32f3_discovery_accelerometer.h"
#include <math.h>
#define M_PI 3.14159265359

/* USER CODE END Includes */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */
/* Private variables ---------------------------------------------------------*/

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
void Error_Handler(void);

/* USER CODE BEGIN PFP */
/* Private function prototypes -----------------------------------------------*/

/* USER CODE END PFP */

/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

int main(void)
{

  /* USER CODE BEGIN 1 */
	uint8_t vuelta=0;
	int16_t lecturas[3]={0,0,0};
	float atan;
	float error=2*0.03925;
	
  /* USER CODE END 1 */

  /* MCU Configuration----------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* Configure the system clock */
  SystemClock_Config();

  /* Initialize all configured peripherals */
  MX_GPIO_Init();

  /* USER CODE BEGIN 2 */
  fprintf(stderr, "\nHola: empieza el programa\n"); 
  BSP_MAGNETO_Init(); 
  fprintf(stderr, "\nTras el init\n"); 
  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
		vuelta++;
		HAL_Delay(500);
		BSP_MAGNETO_GetXYZ(lecturas);
		atan=atan2(lecturas[1],lecturas[0]);
		fprintf(stderr, "(%d) (%d,%d,%d)\n",
		vuelta,lecturas[0],lecturas[1],lecturas[2]);
		
		//Zapal leda ktory pokazuje polnoc
		//zapalanie na osi z
//if(lecturas[2]>-320 && lecturas[2]<380)
//{
//	HAL_GPIO_WritePin(GPIOE, LD3_Pin|LD4_Pin|LD5_Pin|LD6_Pin|LD7_Pin|LD8_Pin|LD9_Pin|LD10_Pin,GPIO_PIN_SET);
//}
 
	if(lecturas[2]>240)
{
	HAL_GPIO_WritePin(GPIOE, LD3_Pin|LD4_Pin|LD5_Pin|LD6_Pin|LD7_Pin|LD8_Pin|LD9_Pin|LD10_Pin,GPIO_PIN_SET);
}

else if(lecturas[2]<-310)
{
HAL_GPIO_WritePin(GPIOE, LD3_Pin|LD4_Pin|LD5_Pin|LD6_Pin|LD7_Pin|LD8_Pin|LD9_Pin|LD10_Pin, GPIO_PIN_RESET);	
}
else
{
		if(atan>=(-M_PI/8)+error && atan<=(M_PI/8)-error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD10_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOE, LD9_Pin|LD5_Pin|LD6_Pin|LD7_Pin|LD4_Pin|LD3_Pin|LD8_Pin, GPIO_PIN_RESET);
	}
	
	if(atan>=(M_PI/8)-error && atan<=(M_PI/8)+error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD10_Pin|LD9_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOE, LD5_Pin|LD6_Pin|LD7_Pin|LD4_Pin|LD3_Pin|LD8_Pin, GPIO_PIN_RESET);
	}
	
	if(atan>=(M_PI/8)+error && atan<=3*(M_PI/8)-error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD9_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOE, LD10_Pin|LD5_Pin|LD6_Pin|LD7_Pin|LD4_Pin|LD3_Pin|LD8_Pin, GPIO_PIN_RESET);
	}
	
	if(atan>=3*(M_PI/8)-error && atan<=3*(M_PI/8)+error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD7_Pin|LD9_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOE, LD5_Pin|LD6_Pin|LD10_Pin|LD4_Pin|LD3_Pin|LD8_Pin, GPIO_PIN_RESET);
	}
	
	if(atan>=3*(M_PI/8)+error && atan<=5*(M_PI/8)-error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD7_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOE, LD9_Pin|LD5_Pin|LD6_Pin|LD10_Pin|LD4_Pin|LD3_Pin|LD8_Pin, GPIO_PIN_RESET);
	}
	
	if(atan>=5*(M_PI/8)-error && atan<=5*(M_PI/8)+error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD7_Pin|LD5_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOE, LD9_Pin|LD6_Pin|LD10_Pin|LD4_Pin|LD3_Pin|LD8_Pin, GPIO_PIN_RESET);
	}
	
	if(atan>=5*(M_PI/8)+error && atan<=7*(M_PI/8)-error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD5_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOE, LD9_Pin|LD10_Pin|LD6_Pin|LD7_Pin|LD4_Pin|LD3_Pin|LD8_Pin, GPIO_PIN_RESET);
	}
	
	if(atan>=7*(M_PI/8)-error && atan<=7*(M_PI/8)+error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD5_Pin|LD3_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOE, LD10_Pin|LD6_Pin|LD10_Pin|LD4_Pin|LD9_Pin|LD8_Pin, GPIO_PIN_RESET);
	}
	
	if(atan>=7*(M_PI/8)+error || atan<=7*(-M_PI/8)-error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD3_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOE, LD9_Pin|LD5_Pin|LD6_Pin|LD7_Pin|LD4_Pin|LD10_Pin|LD8_Pin, GPIO_PIN_RESET);
	}
	
	if(atan>=-7*(M_PI/8)-error && atan<=-7*(M_PI/8)+error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD3_Pin|LD4_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOE, LD5_Pin|LD6_Pin|LD10_Pin|LD7_Pin|LD9_Pin|LD8_Pin, GPIO_PIN_RESET);
	}
	
	if(atan>=7*(-M_PI/8)+error && atan<=5*(-M_PI/8)-error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD4_Pin, GPIO_PIN_SET);
	 HAL_GPIO_WritePin(GPIOE, LD9_Pin|LD5_Pin|LD6_Pin|LD7_Pin|LD10_Pin|LD3_Pin|LD8_Pin, GPIO_PIN_RESET);
	}
	
		if(atan>=-5*(M_PI/8)-error && atan<=-5*(M_PI/8)+error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD6_Pin|LD4_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOE, LD5_Pin|LD3_Pin|LD10_Pin|LD7_Pin|LD9_Pin|LD8_Pin, GPIO_PIN_RESET);
	}
	
		if(atan>=5*(-M_PI/8)+error && atan<=3*(-M_PI/8)-error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD6_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOE, LD9_Pin|LD5_Pin|LD10_Pin|LD7_Pin|LD4_Pin|LD3_Pin|LD8_Pin, GPIO_PIN_RESET);
	}
	
	if(atan>=3*(-M_PI/8)-error && atan<=3*(-M_PI/8)+error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD6_Pin|LD8_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOE, LD9_Pin|LD5_Pin|LD10_Pin|LD7_Pin|LD4_Pin|LD3_Pin, GPIO_PIN_RESET);
	}
	
	if(atan>=3*(-M_PI/8)+error && atan<=(-M_PI/8)-error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD8_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOE, LD9_Pin|LD5_Pin|LD6_Pin|LD7_Pin|LD4_Pin|LD3_Pin|LD10_Pin, GPIO_PIN_RESET);
	}
	
	if(atan>=(-M_PI/8)-error && atan<=(-M_PI/8)+error)
	{	
		HAL_GPIO_WritePin(GPIOE, LD8_Pin|LD10_Pin, GPIO_PIN_SET);
		HAL_GPIO_WritePin(GPIOE, LD9_Pin|LD5_Pin|LD7_Pin|LD4_Pin|LD3_Pin|LD6_Pin, GPIO_PIN_RESET);
	}
}
}
	/* USER CODE END WHILE */
	 
	/* USER CODE BEGIN 3 */
	
  /* USER CODE END 3 */
}

/** System Clock Configuration
*/
void SystemClock_Config(void)
{

  RCC_OscInitTypeDef RCC_OscInitStruct;
  RCC_ClkInitTypeDef RCC_ClkInitStruct;
  RCC_PeriphCLKInitTypeDef PeriphClkInit;

    /**Initializes the CPU, AHB and APB busses clocks 
    */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI|RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_BYPASS;
  RCC_OscInitStruct.HSEPredivValue = RCC_HSE_PREDIV_DIV1;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = 16;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL9;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }

    /**Initializes the CPU, AHB and APB busses clocks 
    */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2) != HAL_OK)
  {
    Error_Handler();
  }

  PeriphClkInit.PeriphClockSelection = RCC_PERIPHCLK_I2C1;
  PeriphClkInit.I2c1ClockSelection = RCC_I2C1CLKSOURCE_HSI;
  if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInit) != HAL_OK)
  {
    Error_Handler();
  }

    /**Configure the Systick interrupt time 
    */
  HAL_SYSTICK_Config(HAL_RCC_GetHCLKFreq()/1000);

    /**Configure the Systick 
    */
  HAL_SYSTICK_CLKSourceConfig(SYSTICK_CLKSOURCE_HCLK);

  /* SysTick_IRQn interrupt configuration */
  HAL_NVIC_SetPriority(SysTick_IRQn, 0, 0);
}

/* USER CODE BEGIN 4 */

/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @param  None
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler */
  /* User can add his own implementation to report the HAL error return state */
  while(1) 
  {
  }
  /* USER CODE END Error_Handler */ 
}

#ifdef USE_FULL_ASSERT

/**
   * @brief Reports the name of the source file and the source line number
   * where the assert_param error has occurred.
   * @param file: pointer to the source file name
   * @param line: assert_param error line source number
   * @retval None
   */
void assert_failed(uint8_t* file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
    ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */

}

#endif

/**
  * @}
  */ 

/**
  * @}
*/ 

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
